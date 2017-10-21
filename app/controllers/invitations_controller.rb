class InvitationsController < ApplicationController


  def search_members
    if params[:search_query].nil? || params[:search_query].empty? || params[:search_query].blank?

      # If the household has pending invitations, we want to remove the users that are
      # invited to the current household from the list of users to invite. Note that
      # by not specifying whether the invitation is actually an invitation or not,
      # we're also filtering out users that have already applied to the household.
      # This is intentional.
      if household_has_pending_invitations?(current_user.household.id)
        @users = User.where("household_id IS NULL AND activated = ? AND id NOT IN ( ? )",
        true,
        Invitation.where( household_id: current_user.household.id).map{ |invitation| invitation.user_id } )
      # Else, we just want to get a list of users that are activated and don't have households:
      else
        @users = User.where(household_id: nil, activated: true)
      end
    else
      @users = User.where("firstname LIKE ? OR surname LIKE ? AND household_id = ? AND activated = ?",
        "%#{params[:search_query]}%", #firstname
        "%#{params[:search_query]}%", #surname
        nil, # household_id
        true) #activated
    end
  end


  # Household.where("joinable = ? AND id NOT IN ?", true, Invitation.where(user_id: @user.ids).map{ |invitation| invitation.household_id})
  # Household.where("joinable = ? AND id NOT IN ( ? )", true, Invitation.where(user_id: @user.ids).map{ |invitation| invitation.household_id})
  def search_households
    @invitation = Invitation.new
    if params[:search_query].nil? || params[:search_query].empty? || params[:search_query].blank?
      if has_pending_applications?(current_user)
        @households = Household.where("joinable = ? AND id NOT IN ( ? )",
            true,
            Invitation.where(user_id: current_user.id).map{ |invitation| invitation.household_id})
      else
        @households = Household.where("joinable = ?", true)
      end
    else
      @households = User.joins("INNER JOIN households ON households.id = users.household_id").distinct.where("users.firstname LIKE ? OR users.surname LIKE ? AND households.joinable = ?",
        "%#{params[:search_query]}%",
        "%#{params[:search_query]}%",
        true).select("households.id")
    end
  end

  def create_household_application
    respond_to do |format|
      if Invitation.create!(user_id: params[:user_id],
                            household_id: params[:household_id],
                            is_invitation: false)
        format.html {
          flash[:success] = "You successfully applied to the household."
          redirect_to root_url
        }
      else
        format.html {
          flash[:error] = "Couldn't apply to that household."
          redirect_back_or(root_url)
        }
      end
    end
  end

  def create_household_invitation
    respond_to do |format|
      if Invitation.create!(user_id: params[:user_id],
                            household_id: params[:household_id],
                            is_invitation: true)
        format.html {
          flash[:success] = "You successfully invited that user to the household."
          redirect_to root_url
        }
      else
        format.html {
          flash[:error] = "Couldn't invite that user to the household."
          redirect_back_or(root_url)
        }
      end
    end
  end

  def rescind_invitation
    respond_to do |format|
      if Invitation.where(user_id: params[:user_id], household_id: params[:household_id]).delete_all
        format.html {
          flash[:success] = "You successfully rescinded that member's invitation to that household."
          redirect_to root_url
        }
      else
        format.html {
          flash[:error] = "Couldn't rescind that invitation."
          redirect_back_or(root_url)
        }
      end
    end
  end


  def rescind_application
    respond_to do |format|
      if Invitation.where(user_id: params[:user_id], household_id: params[:household_id]).delete_all
        format.html {
          flash[:success] = "You successfully rescinded your application to that household."
          redirect_to root_url
        }
      else
        format.html {
          flash[:error] = "Couldn't rescind that application."
          redirect_back_or(root_url)
        }
      end

    end
  end

  # Decline a user's application into a household, by simply deleting that particular application.
  def decline_application
    respond_to do |format|
      if Invitation.where(user_id: params[:user_id], household_id: params[:household_id]).delete_all
        format.html {
          flash[:success] = "You successfully declined that user's application."
          redirect_back_or(root_url)
        }
      else
        format.html {
          flash[:error] = "Couldn't decline that user's application."
          redirect_back_or(root_url)
        }
      end
    end
  end

  # Accept a user's application into a household, by updating the user's household_id attribute and deleting that user's
  # pending invitations and   applications.
  def accept_application
    respond_to do |format|
      if User.find_by(id: params[:user_id]).update_attributes(household_id: params[:household_id]) &&
        Invitation.where(user_id: params[:user_id]).delete_all
        format.html {
          flash[:success] = "You successfully accepted that user's application, making the user a member and clearing all pending invitations and applications for that user."
          redirect_back_or(root_url)
        }
      else
        format.html {
          flash[:error] = "Couldn't accept that user's application."
          redirect_back_or(root_url)
        }
      end
    end
  end

  # Decline an invitation to become a member of a household, by deleting that particular invitation.
  def decline_invitation
    respond_to do |format|
      if Invitation.where(user_id: params[:user_id], household_id: params[:household_id]).delete_all
        format.html {
          flash[:success] = "You successfully declined the invitation to that household."
          redirect_back_or(root_url)
        }
      else
        format.html {
          flash[:error] = "Couldn't decline that invitation."
          redirect_back_or(root_url)
        }
      end
    end
  end

  # Accept an invitation to become a member of a household, by updating the user's household_id attribute and
  # deleting all pending invitations and applications for that user.
  def accept_invitation
    respond_to do |format|
      if User.find_by(id: params[:user_id]).update_attributes(household_id: params[:household_id]) &&
        Invitation.where(user_id: params[:user_id]).delete_all
        format.html {
          flash[:success] = "You successfully accepted the invitation, becoming a member of that household and clearing all pending applications and invitations."
          redirect_back_or(root_url)
        }
      else
        format.html {
          flash[:error] = "Couldn't accept the invitation."
          redirect_back_or(root_url)
        }
      end
    end
  end

  def new
  end
# I want all the firstnames and surnames of users belonging to households


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def invitations_params
    params.require(:invitation).permit(:user_id, :household_id, :is_invitation, :search_query)
  end

  # Does the user have pending invitations?
  def has_pending_invitations?(user)
    !Invitation.where("user_id = ? AND is_invitation = ?", user.id, true).empty?
  end

  # Does the household have pending invitations?
  def household_has_pending_invitations?(household_id)
    !Invitation.where("household_id = ? AND is_invitation = ?", household_id, true).empty?
  end

  # Does the user have pending applications?
  def has_pending_applications?(user)
    !Invitation.where("user_id = ? AND is_invitation = ?", user.id, false).empty?
  end

  # Give an array of IDs for which the user has applied for.
  def pending_invitations(user)
  end

  # Give an array of IDs for which the user has been invited to.
  def pending_applications(user)
  end
end

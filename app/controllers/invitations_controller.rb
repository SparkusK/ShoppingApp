class InvitationsController < ApplicationController


  def search_members
    if params[:search_query].nil? || params[:search_query].empty?
      @users = User.where("household_id = ? AND activated = ?", nil, true)
    else
      @users = User.where("firstname LIKE ? OR surname LIKE ? AND household_id = ? AND activated = ?",
        "%#{params[:search_query]}%",
        "%#{params[:search_query]}%",
        nil,
        true)
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

  def decline
  end

  def accept
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

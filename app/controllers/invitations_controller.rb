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

  def search_households
    @invitation = Invitation.new
    if params[:search_query].nil? || params[:search_query].empty?
      @households = Household.where("joinable = ?", true)
    else
      @households = User.joins("INNER JOIN households ON households.id = users.household_id").distinct.where("users.firstname LIKE ? OR users.surname LIKE ? AND households.joinable = ?",
        "%#{params[:search_query]}%",
        "%#{params[:search_query]}%",
        true).select("households.id")
    end
  end

  def rescind
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
end

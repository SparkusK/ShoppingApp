module InvitationsHelper
  def get_applications(user)
    @applications = user.invitations.where("is_invitation = ?", false)
  end

  def get_invitations(user)
    @invitations = user.invitations.where("is_invitation = ?", true)
  end

end

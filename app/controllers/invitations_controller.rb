class InvitationsController < ApplicationController

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def invitations_params
    params.require(:invitation).permit(:user_id, :household_id, :is_invitation)
  end
end

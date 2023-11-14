class RenameApplicationsToInvitations < ActiveRecord::Migration[5.1]
  def change
    rename_table :applications, :invitations
  end
end

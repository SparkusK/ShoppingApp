class RenameIsApplicationToIsInvitation < ActiveRecord::Migration[5.1]
  def change
    rename_column :invitations, :is_application, :is_invitation
    change_column_null :invitations, :is_invitation, false
  end
end

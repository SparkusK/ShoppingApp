class EditInvitationsIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :invitations, name: "index_invitations_on_user_id_and_household_id"
    add_index :invitations, [:household_id, :user_id], unique: true
  end
end

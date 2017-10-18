class EditInvitationsIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :invitations, name: "I_INV_USE_ID_HOU_ID"
    add_index :invitations, [:household_id, :user_id], unique: true
  end
end

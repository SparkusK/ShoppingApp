class CreateJoinTableUsersHouseholds < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :households, table_name: :applications do |t|
      t.boolean :is_application
      t.timestamps
      t.index [:user_id, :household_id]

    end
  end
end

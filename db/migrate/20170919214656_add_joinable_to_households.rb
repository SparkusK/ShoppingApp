class AddJoinableToHouseholds < ActiveRecord::Migration[5.1]
  def change
    add_column :households, :joinable, :boolean
  end
end

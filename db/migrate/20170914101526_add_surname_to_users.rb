class AddSurnameToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :name, :firstname
    add_column :users, :surname, :string
  end
end

class EditUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string, null: false
    remove_column :users, :name 
    remove_column :users, :email
    add_index :users, :username, unique: true 
  end
end

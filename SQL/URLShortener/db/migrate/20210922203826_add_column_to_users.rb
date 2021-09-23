class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :premium, :boolean, default: false 
  end
end

class AddUserId < ActiveRecord::Migration[6.1]
  def change
    add_column :cats, :user_id, :integer, null: false 
    add_index :cats, :user_id
  end
end

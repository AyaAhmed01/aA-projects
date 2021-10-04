class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.integer :author_id, null: false 
      t.integer :artwork_id, null: false
      t.index :author_id
      t.index :artwork_id
      t.timestamps
    end
  end
end

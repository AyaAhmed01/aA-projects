class CreateArtworkShare < ActiveRecord::Migration[6.1]
  def change
    create_table :artwork_shares do |t|
      t.integer :viewer_id, null: false
      t.integer :artwork_id, null: false
      t.index [:viewer_id, :artwork_id], unique: true 
      t.index :viewer_id
      t.index :artwork_id
      t.timestamps
    end
  end
end

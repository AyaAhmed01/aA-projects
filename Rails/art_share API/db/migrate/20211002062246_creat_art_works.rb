class CreatArtWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :art_works do |t|
      t.string :title, null: false 
      t.string :image_url, null: false
      t.integer :artist_id,  null: false 
      t.index [:title, :artist_id], unique: true 
      t.index :artist_id
      t.timestamps
    end
  end
end

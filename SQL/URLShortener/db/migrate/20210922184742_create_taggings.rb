class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|
      t.integer :url_id, null: false 
      t.integer :tag_id, null: false 
      t.timestamps
    end
    add_index :taggings, :url_id
    add_index :taggings, %i(url_id tag_id), unique: true # CREATE UNIQUE INDEX index_taggings_on_url_id_and_tag_id ON taggings(url_id, tag_id)
  end
end

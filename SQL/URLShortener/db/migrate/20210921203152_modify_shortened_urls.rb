class ModifyShortenedUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false
      t.string :short_url, unique: true
      t.integer :user_id, null: false 
      t.timestamps
    end
    add_index :shortened_urls, :short_url, unique: true
  end
end

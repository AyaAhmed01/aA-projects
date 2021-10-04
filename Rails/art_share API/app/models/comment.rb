class Comment < ApplicationRecord 
    validates :body, presence: true 
    belongs_to :author,
        foreign_key: :author_id,
        class_name: 'User'

    belongs_to :artwork,
        foreign_key: :artwork_id,
        class_name: 'ArtWork'
end
# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  url_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Visit < ApplicationRecord
    validates :user_id, presence: true 
    validates :url_id, presence: true 

    def self.record_visit!(user, shortened_url)
        Visit.create!(user_id: user.id, url_id: shortened_url.id)
    end

    belongs_to :user,
        primary_key: :id, 
        foreign_key: :user_id,
        class_name: :User
        
    belongs_to :url,
        foreign_key: :url_id,
        class_name: :ShortenedUrl
end

# == Schema Information
#
# Table name: taggings
#
#  id         :bigint           not null, primary key
#  url_id     :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tagging < ApplicationRecord
    validates :url_id, presence: true
    validates :tag_id, presence: true
    validates :url_id, uniqueness: { scope: :tag_id }


    belongs_to :url,
        foreign_key: :url_id,
        class_name: :ShortenedUrl

    belongs_to :tag,
        foreign_key: :tag_id,
        class_name: :TagTopic
end

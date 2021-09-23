# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagTopic < ApplicationRecord
    validates :title, presence: true

    has_many :taggings,
        foreign_key: :tag_id,
        class_name: :Tagging

    has_many :links,
        through: :taggings,
        source: :url 

    def popular_links
        links.sort{|a, b| b.num_clicks <=> a.num_clicks}
        links.take(5).map{|link| [link.long_url, link.short_url, link.num_clicks]}
        #other way
        # links.joins(:visits)
        #     .group(:short_url, :long_url)
        #     .order('COUNT(visits.id) DESC')
        #     .select('long_url, short_url, COUNT(visits.id) as number_of_visits')
        #     .limit(5)
    end
end

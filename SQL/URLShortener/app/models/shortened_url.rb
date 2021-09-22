require 'securerandom'
class ShortenedUrl < ApplicationRecord
    validates :user_id , presence: true
    validates :long_url, presence: true
    validates :short_url, uniqueness: true

    belongs_to :submitter,
        primary_key: :id, 
        foreign_key: :user_id,
        class_name: :User 
    
    has_many :visits,
        primary_key: :id,
        foreign_key: :url_id,
        class_name: :Visit

    has_many :visitors,        #add a magic "scope block" to ask Rails to remove duplicates
        -> {distinct},        # same as: Proc.new{distinct}
        through: :visits,
        source: :user

    def self.random_code
        shortUrl = SecureRandom.urlsafe_base64 
        while exists?(short_url: shortUrl)
            shortUrl = SecureRandom.urlsafe_base64 
        end
        shortUrl
    end

    def self.new_url (user, longUrl)
        ShortenedUrl.create!(user_id: user.id, long_url: longUrl, short_url: ShortenedUrl.random_code)
    end

    def num_clicks
        visits.length
    end

    def num_uniques      # determine the number of distinct users who have clicked a link.
        # visits.select(:user_id).distinct.count ==>  one solution: as visits users are NOT unique 
        # simple sol. using unique visitors
        visitors.length 
    end

    def num_recent_uniques(time = 50.minutes.ago)
        visits
            .select(:user_id)
            .where('created_at > ?', time)
            .distinct
            .count
    end
end
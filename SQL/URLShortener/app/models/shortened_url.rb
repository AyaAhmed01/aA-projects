# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'securerandom'
class ShortenedUrl < ApplicationRecord
    validates :user_id ,:long_url, presence: true
    validates :short_url, uniqueness: true
    validate :no_spamming, :nonpremium_max

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

    has_many :taggings,
        foreign_key: :url_id,
        class_name: :Tagging

    has_many :tag_topics,
        through: :taggings,
        source: :tag 
        
    def self.random_code
        shortUrl = SecureRandom.urlsafe_base64 
        while exists?(short_url: shortUrl)
            shortUrl = SecureRandom.urlsafe_base64 
        end
        shortUrl
    end

    def self.create_for_user_and_long_url! (user, longUrl)
        ShortenedUrl.create!(user_id: user.id, long_url: longUrl, short_url: ShortenedUrl.random_code) 
    end

    def self.prune(n)
        ShortenedUrl
            .joins(:submitter)  # :submitter MUST be ASSOCIATION of ShortenedUrl class
            .joins("LEFT JOIN visits ON visits.url_id = shortened_urls.id")  # visits, users MUST be TABLES
            .where("(shortened_urls.id IN(
                SELECT shortened_urls.id
                FROM shortened_urls
                JOIN visits ON visits.url_id = shortened_urls.id
                GROUP BY shortened_urls.id
                HAVING MAX(visits.created_at) < \'#{n.minute.ago}\')
                OR visits.id IS NULL AND shortened_urls.created_at < \'#{n.minute.ago}\') 
                AND users.premium = \'f\'")
                .destroy_all
        
        # The sql for the query would be:

        # SELECT shortened_urls.*
        # FROM shortened_urls
        # JOIN users ON users.id = shortened_urls.submitter_id
        # LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id
        # WHERE (shortened_urls.id IN (
        #   SELECT shortened_urls.id
        #   FROM shortened_urls
        #   JOIN visits ON visits.shortened_url_id = shortened_urls.id
        #   GROUP BY shortened_urls.id
        #   HAVING MAX(visits.created_at) < "#{n.minute.ago}"
        # ) OR (
        #   visits.id IS NULL and shortened_urls.created_at < '#{n.minutes.ago}'
        # )) AND users.premium = 'f'
    end
    
    def num_clicks
        visits.length
    end

    def num_uniques      # determine the number of distinct users who have clicked a link.
        # visits.select(:user_id).distinct.count ==>  one solution: as visits users are NOT unique 
        
        visitors.length # simple sol. using unique visitors
    end

    def num_recent_uniques(time = 10.minutes.ago)
        visits
            .select(:user_id)
            .where('created_at > ?', time)
            .distinct
            .count
    end


    private
    def nonpremium_max
        if !submitter.premium && submitter.submitted_urls.count > 5
            errors[:base] << "Non-premium users can't submit more than 5 URLs" 
        end
    end

    def no_spamming
        urls_in_last_minute = submitter.submitted_urls.where('created_at >= ?', 1.minute.ago).count
        if urls_in_last_minute > 5
            errors[:maximum] << " of short URLs per minute"
        end
    end
end

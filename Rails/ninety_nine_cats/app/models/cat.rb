require 'action_view'
class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper
    COLORS = ['brown', 'white', 'black', 'grey']

    validates :birth_date, :color, :name, :sex,  presence: true
    validates :color, inclusion: {in: COLORS, message: "%{value} is not a valid color"}
    validates :sex , inclusion: {in: %w(M F)}, if: -> {sex}
    validate :birth_date_in_the_past, if: -> {birth_date}

    has_many :cat_rental_requests, dependent: :destroy
    belongs_to :owner,
        foreign_key: :user_id, 
        class_name: 'User'

    def age
        time_ago_in_words(birth_date)
    end

    private
    def birth_date_in_the_past
        if birth_date && birth_date > Time.now 
            errors[:birth_date] << "must be in the past"
        end
    end
end
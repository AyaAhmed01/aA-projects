class Cat < ApplicationRecord

    COLORS = ['brown', 'white', 'black', 'grey']

    validates :birth_date, :color, :name, :sex,  presence: true
    validates :color, inclusion: {in: COLORS, message: "%{value} is not a valid color"}
    validates :sex , inclusion: {in: %w(M F)}

    def age
        now = Time.now.utc.year 
        age = now - birth_date.year 
        if now.month < birth_date.month
            age -=1
        elsif now.month == birth_date.month
            age-=1 if now.day < birth_date.day 
        end
        age 
    end
end
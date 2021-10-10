class User < ApplicationRecord
    attr_reader :password 

    validates :user_name, :session_token, presence: true, uniqueness: true 
    validates :password_digest, presence: {message: "Password can/'t be blank"}
    validates :password, length: {minimum: 6, allow_nil: true}
    after_initialize :ensure_session_token

    has_many :cats 
    has_many :requests,
        foreign_key: :requester_id,
        class_name: 'CatRentalRequest'

    def self.generate_session_token
        SecureRandom.urlsafe_base64(16)
    end

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
        return user if user && user.is_password?(password)
        nil 
    end

    def owns_cat?(cat)
        cat.user_id == self.id 
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    private
    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

end


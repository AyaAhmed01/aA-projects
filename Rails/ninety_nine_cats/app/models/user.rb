class User < ApplicationRecord
    attr_reader :password 

    validates :user_name, :session_token, presence: true, unique: true 
    validates :password_digest, presence: {message: "Password can/'t be blank"}
    validates :password, length: {minimum: 6, allow_nil: true}
    after_initialize :ensure_session_token

    def self.generate_session_token
        SecureRandom::urlsafe.base_64(16)
    end

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
        return user if user && is_password?(password)
        nil 
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

end


# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

# F - Find_by_credentials

    def find_by_credentials(usnm, pw)
        user = User.find_by(username: usnm)

        return user if user && user.is_password?(pw) 
        nil
    end

# I - is_password? +

    def is_password?(pw)
        password_object = BCrypt::Password(self.password_digest)
        password_object.is_password?(pw)
    end

# G - generate_session_token
    def generate_session_token
        SecureRandom.urlsafe_base64
    end
# V - validates +
    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence:true
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: {minimum: 6}, allow_nil: true

# A - attr_reader
    attr_reader :password
# P - password=
    def password=(new_pw)
        self.password_digest = BCrypt::Password.create(new_pw)
        @password = new_pw
    end
# E - ensure_session_token
    def ensure_session_token
        self.session_token ||= generate_session_token
    end
# B - before_validation
    after_initialize :ensure_session_token
# R - reset_session_token
end

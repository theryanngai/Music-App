class User < ActiveRecord::Base
	attr_reader :password
	validates :email, presence: true, uniqueness: true
	validates :session_token, presence: true, uniqueness:true
	validates :password, length: { minimum: 6, allow_nil: true }

	after_initialize :ensure_session_token

	def self.generate_session_token
		SecureRandom::urlsafe_base64
	end

	def reset_session_token!
		self.session_token = User.generate_session_token
	end

	def password=(password)
		@password=password
		self.password_digest = BCrypt::Password.create(password)
	end

	def is_password?(password)
		BCrypt::Password.new(self.password_digest).is_password?(password)
	end

	def self.find_by_credentials(email, password)
		user = User.find_by_email(email)
		return nil unless user
		return nil unless user.is_password?(password)
		user
	end


	private

	def ensure_session_token
		self.session_token ||= reset_session_token!
	end
end

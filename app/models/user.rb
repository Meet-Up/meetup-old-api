class User < ActiveRecord::Base
	has_many :possible_dates
	attr_accessible :name, :token, :email

	TOKEN_LENGTH = 20

	def refresh_token
		self.token = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
	end
end

class User < ActiveRecord::Base
	has_many :possible_dates
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
	attr_accessible :name, :token, :email

	TOKEN_LENGTH = 20

	def refresh_token
		self.token = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
	end

  def username
    self.email.split('@')[0]
  end
end

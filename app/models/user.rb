class User < ActiveRecord::Base
  attr_accessible :email
  TOKEN_LENGTH = 20
  def refresh_token
  	self.token = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
  end
end

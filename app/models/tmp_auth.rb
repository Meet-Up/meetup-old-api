class TmpAuth < ActiveRecord::Base
  attr_accessible :email

  before_create :set_token, :set_pin

  TOKEN_LENGTH = 20

  private
  def set_token
    self.token = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
  end

  def set_pin
    self.pin = (1..4).map { rand(0..9) }.join.to_i
  end
end

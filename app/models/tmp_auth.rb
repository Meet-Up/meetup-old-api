class TmpAuth < ActiveRecord::Base
  attr_accessible :email

  before_create :set_token, :set_pin

  TOKEN_LENGTH = 20

  def create_user
    user = User.find_or_initialize_by_email(self.email)
    user.refresh_token
    self.destroy
    user.save
    user
  end

  def as_json(options={})
    super(except: [:pin])
  end

  private
  def set_token
    self.token = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
  end

  def set_pin
    self.pin = (1..4).map { rand(0..9) }.join.to_i
  end
end

class User < ActiveRecord::Base
	has_many :possible_dates
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
	attr_accessible :name, :token, :email

  has_many :email_addresses
  has_many :phone_numbers

	TOKEN_LENGTH = 20

  def self.with_email_or_number_in(emails, numbers)
    email_t = EmailAddress.arel_table
    number_t = PhoneNumber.arel_table
    condition = email_t[:email].in(emails).or(number_t[:phone_number].in(numbers))
    User.includes(:email_addresses, :phone_numbers)
        .where(condition)
  end

	def refresh_token
		self.token = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
	end

  def username
    self.email.split('@')[0]
  end
end

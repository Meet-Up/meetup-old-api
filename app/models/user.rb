class User < ActiveRecord::Base
  has_many :event_users
  has_many :events, through: :event_users
  has_many :possible_dates
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  attr_accessible :email

  has_many :email_addresses
  has_many :phone_numbers

	TOKEN_LENGTH = 20

  def as_json(options={})
    super( { except: :token }.merge(options))
  end

  def get_possible_dates(event_id)
    self.possible_dates.where(event_id: event_id)
  end

  def refresh_token
    self.token = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
  end

  def self.with_email_or_number_in(emails, numbers)
    email_t = EmailAddress.arel_table
    number_t = PhoneNumber.arel_table
    condition = email_t[:email].in(emails).or(number_t[:phone_number].in(numbers))
    User.includes(:email_addresses, :phone_numbers)
        .where(condition)
  end

  def username
    self.email.split('@')[0]
  end

  def add_missing_info(info)

  end
end

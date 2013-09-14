class User < ActiveRecord::Base
  has_many :event_users
  has_many :events, through: :event_users
  has_many :possible_dates
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  attr_accessible :email

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

  def username
    self.email.split('@')[0]
  end
end

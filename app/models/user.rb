class User < ActiveRecord::Base
  has_many :event_users
  has_many :events, through: :event_users
  has_many :possible_dates
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  attr_accessible :email

  TOKEN_LENGTH = 20

  def as_json(options)
    super( {except: :token }.merge(options))
  end

  def refresh_token
    self.token = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
  end

  def username
    self.email.split('@')[0]
  end

  def self.participants(event_id)
    users = User.includes(:possible_dates)
                .joins(:events)
                .where('events.id', event_id)
                .uniq
    # FIXME: fix this horror with a left outer join or something
    users.each { |u| u.possible_dates.select! { |p| p.event_id == event_id } }
  end
end

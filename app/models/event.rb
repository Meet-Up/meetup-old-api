class Event < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :event_dates
  has_many :event_users
  has_many :event_token
  has_many :possible_dates
  has_many :users, through: :possible_dates

  attr_accessible :description, :name , :event_dates_attributes
  accepts_nested_attributes_for :event_dates

  def participants_number
    self.users.uniq.count
  end

  def participants
    User.includes(:possible_dates)
        .where('possible_dates.event_id' => self.id)
        .uniq
  end

  def as_json(options={})
    super( {
      include: [:event_dates, creator: {only: :username, methods: :username}],
      methods: :participants_number
    }.merge(options))
  end
end

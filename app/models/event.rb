class Event < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :event_dates
  has_many :invitations
  has_many :invited_users, through: :invitations
  has_many :event_token
  has_many :possible_dates
  has_many :users, through: :possible_dates

  attr_accessible :description, :name , :event_dates_attributes
  accepts_nested_attributes_for :event_dates

  def participants_number
    self.users.uniq.count
  end

  # FIXME: raw SQL could probably be avoided
  def participants
    User.joins(:invitations)
        .where('invitations.event_id' => self.id)
        .includes(:possible_dates)
        .joins("LEFT OUTER JOIN possible_dates
                ON possible_dates.user_id = users.id
                AND possible_dates.event_id = #{ActiveRecord::Base.sanitize(self.id)}"
        )
        .uniq
  end

  def as_json(options={})
    super( {
      include: [:event_dates, creator: {only: :username, methods: :username}],
      methods: :participants_number
    }.merge(options))
  end
end

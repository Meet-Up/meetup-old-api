class PossibleDate < ActiveRecord::Base
	belongs_to :event
	belongs_to :event_date
	belongs_to :user

	attr_accessible :event_date_id, :event_id, :possible_time, :user_id
end

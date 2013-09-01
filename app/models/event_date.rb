class EventDate < ActiveRecord::Base
	has_many :possible_dates
	belongs_to  :event
	attr_accessible :end, :event_id, :start
end

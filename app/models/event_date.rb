class EventDate < ActiveRecord::Base
	has_many :possible_dates
	belongs_to  :event
	attr_accessible :end, :event_id, :start

  accepts_nested_attributes_for :possible_dates
end

class Event < ActiveRecord::Base
	has_many :event_dates
	has_many :possible_dates
	has_many :users,through:  :possible_dates

	attr_accessible :description, :name , :event_dates_attributes
	accepts_nested_attributes_for :event_dates

	def as_json(option={})
		super(:include => [:event_dates])
	end
end

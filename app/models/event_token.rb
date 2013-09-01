class EventToken < ActiveRecord::Base
	belongs_to  :event
	attr_accessible :event_id, :token, :user_id
end

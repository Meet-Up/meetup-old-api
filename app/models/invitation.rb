class Invitation < ActiveRecord::Base
	belongs_to  :event
	belongs_to :user
	attr_accessible :event_id, :user_id
end

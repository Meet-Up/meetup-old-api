class EventToken < ActiveRecord::Base
	belongs_to  :event
	attr_accessible :event_id, :token, :user_id

	def get_url
		return "http://www.imaggle.com/scheduler?token=" + self.token
		#return "http://localhost:3000/scheduler?token=" + self.token
	end
end

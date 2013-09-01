class EventsController < ApplicationController
	TOKEN_LENGTH = 20
	def create
		@event = Event.new(params[:event])
		if @event.save
			users = params[:user]
			#puts YAML::dump(users)
			users.each { |mail| 
				u = User.where(email: mail).first
				#puts YAML::dump(u)
				#puts YAML::dump(u.nil?)
				if u.nil? then
					u = User.create(:email => mail)
				end
				secure = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
				EventToken.create(:event_id => @event.id, :user_id => u.id, :token => secure)
			} 
			render json:  @event 
		else 
			render :json  => @event.errors
		end
	end

	def show
		@event = Event.find(params[:id])
		render json: @event 
	end
end

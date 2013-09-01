class EventsController < ApplicationController
	TOKEN_LENGTH = 20
	def create


		@event = Event.new(params[:event])
		#puts YAML::dump(@event)
		if @event.save

			users = params[:user]
			#puts YAML::dump(users)
			users.each { |u| 
				hoge = User.where(email: u).first
				puts YAML::dump(hoge)
				#puts YAML::dump(u)
			} 

			#secure = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
			#EventToken.new(:event_id => @event.id, :user_id => user.id, secure)

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

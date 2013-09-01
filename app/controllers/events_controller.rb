class EventsController < ApplicationController
	TOKEN_LENGTH = 20

  before_filter :auth_user!

  def index
    @event = Event.includes([:creator, :event_dates])
    render json: @event
  end

  def create
	  @event = @user.created_events.build(params[:event])
	  if @event.save
		  users = params[:user]
		  unless users.nil?
			  users.each { |mail|
				  u = User.where(email: mail).first
				  if u.nil? then
					  u = User.create(:email => mail)
				  end
				  secure = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
				  EventToken.create(:event_id => @event.id, :user_id => u.id, :token => secure)
			  }
			  secure = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
			  EventToken.create(:event_id => @event.id, :token => secure)
		  end
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

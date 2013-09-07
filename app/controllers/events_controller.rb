class EventsController < ApplicationController
	TOKEN_LENGTH = 20

  before_filter :auth_user!, except: [:add_possible_dates]

  def index
    @event = Event.includes([:creator, :event_dates])
    render json: @event
  end

  def create
    users = params[:event].delete(:users)
	  @event = @user.created_events.build(params[:event])
	  if @event.save
		  unless users.nil?
			  users.each do |mail|

				  u = User.where(email: mail).first
				  if u.nil? then
					  u = User.create(:email => mail)
				  end
				  EventUser.create(:event_id => @event.id, :user_id => u.id)

				  secure = SecureRandom.urlsafe_base64(TOKEN_LENGTH, false)
				  t = EventToken.create(:event_id => @event.id, :user_id => u.id, :token => secure)

				  EventMailer.delay.invite_email(@event, u.email, t.get_url)

			  end
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

  def add_possible_dates
    event_token = EventToken.find_by_token(params[:token])
    possible_dates = params[:possible_dates]

    unless event_token.nil? || possible_dates.nil? || event_token.event.id != params[:id].to_i
      saved_dates = PossibleDate.save_for_token event_token, possible_dates
      render json: saved_dates
    else
      render json: { errors: 'wrong parameters' }
    end
  end

end

class EventsController < ApplicationController
  TOKEN_LENGTH = 20

  before_filter :auth_user!, only: [:create]

  def index
    @event = Event.includes([:creator, :event_dates])
    render json: @event
  end

  def create
    event_param = params[:event]
    users = event_param.delete(:users)
    event_param[:event_dates_attributes] = event_param.delete(:event_dates) if event_param.has_key? :event_dates
    @event = @user.created_events.build(event_param)
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

  def update_possible_dates
    event_token = EventToken.find_by_token(params[:token])
    possible_dates = params[:possible_dates]

    unless event_token.nil? || possible_dates.nil? || event_token.event.id != params[:id].to_i
      event = event_token.event
      saved_dates = PossibleDate.save_for_token event_token, possible_dates
      WebsocketRails["event-#{event.id}"].trigger 'update', { saved_dates: saved_dates, participants_number: event.participants_number }
      render json: saved_dates
    else
      render json: { errors: 'wrong parameters' }
    end
  end

  def schedule
    event_token = EventToken.find_by_token(params[:token])
    @event = event_token.event
    @user = event_token.user
    @event_dates = @event.event_dates.includes(:possible_dates)
  end

  def participants
    @event = Event.find(params[:id])
    @participants = User.participants(@event.id)
    render json: @participants.as_json(include: :possible_dates)
  end
end

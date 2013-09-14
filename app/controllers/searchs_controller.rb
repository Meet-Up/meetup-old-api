class SearchsController < ApplicationController

  #user_id
  #offset
  #limit

  def events
    u = User.where(:token => params[:token]).last
      render json: u.to_json(:include => [:even_users,:possible_dates])
  end

  def event_detail
      event_details = Event.find(params[:event_id])
      render json: event_details.possible_dates
  end
end

class SearchsController < ApplicationController

	def events
		u = User.where(:token => params[:token]).last
		puts YAML::dump(u.event_users)

		j = {}

		u.event_users.each{ |e|
		}
		#render json: u.event_users
		#render json: {
			#"hoge" => [123,234],
			#"hige" => "ffef"
		#}
	end

	def event_detail
    	event_details = Event.find(params[:event_id])
    	render json: event_details.possible_dates
	end
end

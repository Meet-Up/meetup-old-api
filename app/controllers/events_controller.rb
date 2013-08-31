class EventsController < ApplicationController
	def create
		@event = Event.new(params[:event])
		@event.save
		render json: { event: @event }
	end

	def show
		@event = Event.new(params[:id])
		render json: { event: @event }
	end
end

class PossibleDatesController < ApplicationController
	def create
		@possible_date = PossibleDate.new(params[:possible_date])
		if @possible_date.save
			render json: @possible_date
		else
			render :json  => @possible_date.errors
		end
	end

  def show
	  @possible_date = PossibleDate.find(params[:id])
	  render json: @possible_date
  end
end

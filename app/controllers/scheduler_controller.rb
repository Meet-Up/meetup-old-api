class SchedulerController < ApplicationController
  def respondToToken

	  e = EventToken.where(:token => params[:token]).last

	  dates_tmp = []
	  time_tmp = []
	  e.event.event_dates.each { |d|
		  date_tmp = Time.at(d.start)
		  dates_tmp.push(date_tmp.strftime("%m/%d"))
		  time_tmp.push(date_tmp.strftime("%H"))

		  date_tmp = Time.at(d.end)
		  dates_tmp.push(date_tmp.strftime("%m/%d"))
		  time_tmp.push(date_tmp.strftime("%H"))
	  }

	  @dates=dates_tmp.uniq.sort
	  @s_time=time_tmp.min.to_i
	  @e_time=time_tmp.max.to_i


	  @name = e.event.name
	  @description=e.event.description


	  #puts YAML::dump(time_tmp)
	  #puts YAML::dump(time_tmp.max)
	  #puts YAML::dump(time_tmp.min)
	  #puts YAML::dump(time_tmp)

	  #@dates=["1/1","1/2","1/3","1/4","1/5"]
	  #@s_time=10.5
	  #@e_time=22


	  @rows = (@e_time - @s_time) * 2 -1
	  @cols = @dates.length - 1
	  @cellWidth = [780/(@cols+1),270].min
	  @cellHeight =[1200/(@rows+1),100].max
	  @unselectedColor = "rgb(180, 180, 180)"
	  @selectedColor = "rgb(80, 80, 80)"

	  render "scheduler/main"
  end
end

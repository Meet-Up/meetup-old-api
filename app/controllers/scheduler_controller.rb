class SchedulerController < ApplicationController
  IDEALDATES=["1/1","1/2","1/3","1/4","1/5"]
  IDEALSTARTTIME=10.5
  IDEALENDTIME=22

  def respondToToken

	  #e = EventToken.where(:token => params[:token]).last

	  #dates_tmp = []
	  #time_tmp = []
	  #e.event.event_dates.each { |d|
		  #date_tmp = Time.at(d.start)
		  #dates_tmp.push(date_tmp.strftime("%m/%d"))
		  #time_tmp.push(date_tmp.strftime("%H"))

		  #date_tmp = Time.at(d.end)
		  #dates_tmp.push(date_tmp.strftime("%m/%d"))
		  #time_tmp.push(date_tmp.strftime("%H"))
	  #}

	  #@dates=dates_tmp.uniq.sort
	  #@s_time=time_tmp.min.to_i
	  #@e_time=time_tmp.max.to_i
	  #@name = e.event.name
	  #@description=e.event.description
	@dates=IDEALDATES
	@s_time=IDEALSTARTTIME
	@e_time=IDEALENDTIME
	@name = "大江戸ハッカソン打ち上げパーティー"
	@description="hoge"


	  @rows = (@e_time - @s_time) * 2 
	  @cols = @dates.length - 1
	  @cellWidth = [780/(@cols+1),270].min
	  @cellHeight =[1200/(@rows+1),100].max
	  @unselectedColor = "rgb(180, 180, 180)"
	  @selectedColor = "rgb(80, 80, 80)"
	  render "scheduler/main"

    #@rows = (@e_time - @s_time) * 2 - 1
    #@cols = @dates.length - 1
    #@cellWidth = [800/(@cols+1),270].min
    #@cellHeight =[1200/(@rows+1),100].max
    #@unselectedColor = "#DCDDDD"
    #@selectedColor = "#339933"
    #@name = "大江戸ハッカソン打ち上げパーティー"
    #@description="hoge"

    #render "scheduler/main"
  end

  def postNewTimes
    # process data
    
    # Prepare data and broadcast it via Websocket!
    r = ((IDEALENDTIME - IDEALSTARTTIME) * 2).to_int
    c = IDEALDATES.length
    d = (1..r*c).map{rand(0..10)}
    result = JSON.generate({rows: r, cols: c, data: d})
    WebsocketRails[:newTimes].trigger 'update',  result
    
  end
end

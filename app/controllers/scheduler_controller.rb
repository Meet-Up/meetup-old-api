class SchedulerController < ApplicationController
  IDEALDATES=["1/1","1/2","1/3","1/4","1/5"]
  IDEALSTARTTIME=10.5
  IDEALENDTIME=22
  def respondToToken
    @dates=IDEALDATES
    @s_time=IDEALSTARTTIME
    @e_time=IDEALENDTIME
    @rows = (@e_time - @s_time) * 2 -1
    @cols = @dates.length - 1
    @cellWidth = [780/(@cols+1),270].min
    @cellHeight =[1200/(@rows+1),100].max
    @unselectedColor = "rgb(180, 180, 180)"
    @selectedColor = "rgb(80, 80, 80)"
    @name = "David Liu's mock nomikai"
    @description="hoge"

    render "scheduler/main"
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

class SchedulerController < ApplicationController
  def respondToToken
    @dates=["1/1","1/2","1/3","1/4","1/5"]
    @s_time=10.5
    @e_time=22
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
end

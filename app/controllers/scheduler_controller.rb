class SchedulerController < ApplicationController
  def respondToToken
    @dates=["1/1","1/2","1/3"]
    @s_time=11.5
    @e_time=22
    @rows = (@e_time - @s_time) * 2 -1
    @cols = @dates.length - 1
    @cellWidth = [870/(@cols+1),270].min
    @cellHeight =[1200/(@rows+1),100].max
    @unselectedColor = "#DCDDDD"
    @selectedColor = "#E2EEC5"
    @name = "David Liu's mock nomikai"
    @description="hoge"

    render "scheduler/main"
  end
end

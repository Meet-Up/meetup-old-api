class SchedulerController < ApplicationController
  def respondToToken
    @rows = 24
    @cols = 4
    @cellWidth = [800/(@cols+1),250].min
    @cellHeight = 1200/(@rows+1)
    @unselectedColor = "rgb(180, 180, 180)"
    @selectedColor = "rgb(80, 80, 80)"
    @name = "David Liu's mock nomikai"
    render "scheduler/main"
  end
end

class SchedulerController < ApplicationController
  def respondToToken
    @rows = 20
    @cols = 4
    @cellWidth = 500/(@cols+1)
    @cellHeight = 960/(@rows+1)
    @unselectedColor = "rgb(180, 180, 180)"
    @selectedColor = "rgb(80, 80, 80)"
    @name = "David Liu's mock nomikai"
    render "scheduler/main"
  end
end

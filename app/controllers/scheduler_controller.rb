class SchedulerController < ApplicationController
  def respondToToken
    @cellWidth = 60
    @cellHeight = 30
    @rows = 48
    @cols = 4
    @name = "David Liu's mock nomikai"
    render "scheduler/main"
  end
end

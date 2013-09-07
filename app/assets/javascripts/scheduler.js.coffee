
class Scheduler
  constructor: (eventDates) ->
    @eventDates = new MeetupApi.EventDateCollection eventDates, parse: true
    @view = new MeetupApi.SchedulerView
              collection: @eventDates
    console.log @eventDates.getFastestTime()
    console.log @eventDates.getLatestTime()
    console.log @eventDates.startRow()
    console.log @eventDates.endRow()

new Scheduler App.eventDates

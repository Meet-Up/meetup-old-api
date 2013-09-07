
class Scheduler
  constructor: (eventDates) ->
    @eventDates = new MeetupApi.EventDateCollection eventDates, parse: true
    @view = new MeetupApi.SchedulerView
              rowsNumber: App.rowsNumber
              columnsNumber: App.columnsNumber
    console.log @eventDates.fastestTime()
    console.log @eventDates.latestTime()

new Scheduler App.eventDates

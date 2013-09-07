
class Scheduler
  constructor: (eventDates) ->
    @eventDates = new MeetupApi.EventDateCollection eventDates, parse: true
    @view = new MeetupApi.SchedulerView
              rowsNumber: App.rowsNumber
              columnsNumber: App.columnsNumber
    @eventDates.each (eventDate) ->
      console.log eventDate.get('start')
      console.log eventDate.get('end')



new Scheduler App.eventDates

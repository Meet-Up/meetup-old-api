class Scheduler
  constructor: (eventContent, eventDates) ->
    @event = new MeetupApi.Event eventContent
    @eventDates = new MeetupApi.EventDateCollection eventDates, parse: true
    @event.setEventDates @eventDates
    @view = new MeetupApi.SchedulerView
              collection: @eventDates

new Scheduler App.eventContent, App.eventDates

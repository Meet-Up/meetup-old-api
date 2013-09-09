class Scheduler
  constructor: (eventContent, eventDates) ->
    @event = new MeetupApi.Event eventContent
    @eventDates = new MeetupApi.EventDateCollection eventDates, parse: true
    @event.setEventDates @eventDates
    @view = new MeetupApi.SchedulerView
              collection: @eventDates
    @initView()

  initView: () ->
    $('#title > h1').text @event.get('name')

new Scheduler App.eventContent, App.eventDates

class Scheduler
  webSocketPath: 'localhost:3000/websocket'

  constructor: (eventContent, eventDates) ->
    @event = new MeetupApi.Event eventContent
    @eventDates = new MeetupApi.EventDateCollection eventDates, parse: true
    @event.setEventDates @eventDates
    @schedulerView = new MeetupApi.SchedulerView(
      collection: @eventDates
      el: '#scheduler'
    )
    @heatMapView = new MeetupApi.HeatMapView(
      collection: @eventDates
      model: @event
      el: '#heat-map'
    )

    @titleView = new MeetupApi.EventInfoView({ model: @event })

    @initWSConnection()

  initWSConnection: () ->
    @dispatcher = new WebSocketRails(@webSocketPath)
    @channel = @dispatcher.subscribe("event-#{@event.get 'id'}");
    @channel.bind 'update', @event.updatePossibleDates

new Scheduler App.eventContent, App.eventDates

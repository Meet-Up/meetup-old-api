class MeetupApi.HeatMapView extends MeetupApi.CalendarWeekView
  template: JST["backbone/templates/schedule/calendar"]

  initialize: (@options) ->
    super @options

  createCell: (options) ->
    options.collection = options.eventDate.get 'possible_dates'
    options.totalParticipants = @options.totalParticipants
    cell = new MeetupApi.HeatMapCellView(options)
    cell

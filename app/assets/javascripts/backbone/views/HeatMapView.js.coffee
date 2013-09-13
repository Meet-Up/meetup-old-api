class MeetupApi.HeatMapView extends MeetupApi.CalendarWeekView
  template: JST["backbone/templates/schedule/calendar"]

  initialize: (@options) ->
    super @options

  createCell: (options) ->
    options.collection = options.eventDate.get 'possible_dates'
    options.model = @model
    cell = new MeetupApi.HeatMapCellView(options)
    cell

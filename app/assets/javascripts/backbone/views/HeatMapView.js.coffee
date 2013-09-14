class MeetupApi.HeatMapView extends MeetupApi.CalendarWeekView
  template: JST["backbone/templates/schedule/calendar"]

  initialize: (@options) ->
    super @options
    @model.on 'change', @refreshCells, this

  refreshCells: ->
    _.each @cells, (cell) -> cell.setOpacity()

  createCell: (options) ->
    options.collection = options.eventDate.get 'possible_dates'
    options.model = @model
    cell = new MeetupApi.HeatMapCellView(options)
    cell

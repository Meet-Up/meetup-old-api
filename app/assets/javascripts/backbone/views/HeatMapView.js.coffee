class MeetupApi.HeatMapView extends MeetupApi.CalendarWeekView
  template: JST["backbone/templates/schedule/calendar"]

  initialize: (@options) ->
    super @options

  handleUpdate: (data) ->
    console.log data

  createCell: (options) ->
    cell = new MeetupApi.HeatMapCellView(options)
    cell


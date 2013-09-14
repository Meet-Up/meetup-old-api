class MeetupApi.CalendarWeekView extends Backbone.View
  initialize: (@options) ->
    @startRow = @collection.startRow()
    @endRow = @collection.endRow()

    rowsNumber = @endRow - @startRow + 1
    columnsNumber = @collection.length
    @widthSpan = Math.floor(12 / columnsNumber)
    @height = Math.max(80, 800 / rowsNumber)

    @render()

  render: ->
    @cells = []
    @$el.html @template()
    @collection.each (eventDate) =>
      @$('.dates').append $('<div />').addClass("span#{@widthSpan}").text(eventDate.getShortDate())
    for y in [@startRow..@endRow]
      @addRow y
    return this

  addRow: (y) ->
    @addTimeCell y
    container = $('<div />').attr('class', 'row-fluid')
    @collection.each (eventDate, x) =>
      @addOne eventDate, x, y, container
    @$('.calendar').append container

  addOne: (eventDate, x, y, container) ->
    cellView = @createCell
      eventDate: eventDate
      x: x
      y: y
      height: @height
      widthSpan: @widthSpan
    @cells.push cellView
    container.append cellView.render().el

  addTimeCell: (position, height) ->
    minutes = if position % 2 == 0 then 0 else 30
    time = Date.today().set({hour: Math.floor(position / 2), minute: minutes })
    $timeCell = $('<div />').height(@height).text(time.toString 'HH:mm')
    @$('.time').append $timeCell

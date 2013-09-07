class MeetupApi.SchedulerView extends Backbone.View
  el: '#schedule'

  initialize: (@options) ->
    @startRow = @collection.startRow()
    @endRow = @collection.endRow()
    @render()

  render: ->
    rowsNumber = @endRow - @startRow + 1
    columnsNumber = @collection.length

    height = Math.max(80, 800 / rowsNumber)
    width = Math.min(260, 800 / columnsNumber)

    for y in [@startRow..@endRow]
      container = $('<div />')
      container.attr 'class', 'row'
      @collection.each (eventDate) =>
        possibleDate = eventDate.getPossibleDate()
        cellView = @createCell
          model: possibleDate
          index: y
          height: height
          width: width
        container.append cellView.render().el
      @$el.append container

  createCell: (options) ->
    cell = new MeetupApi.CellView(options)
    cell.on 'dragstart', @onDragStart
    cell.on 'drag', @onDrag
    cell.on 'dragend', @onDragEnd
    cell

  onDragStart: (params) ->
    console.log 'dragstart'

  onDrag: (params) ->
    console.log 'drag'

  onDragEnd: (params) ->
    console.log 'dragend'

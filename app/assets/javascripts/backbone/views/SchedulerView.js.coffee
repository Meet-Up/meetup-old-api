class MeetupApi.SchedulerView extends Backbone.View
  el: '#schedule'

  isSelecting: false
  newSelection: false

  dragStartPoint:
    x: -1
    y: -1

  events:
    'touchmove': 'handleTouchMove'

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
      @collection.each (eventDate, x) =>
        possibleDate = eventDate.getPossibleDate()
        cellView = @createCell
          model: possibleDate
          x: x
          y: y
          height: height
          width: width
        container.append cellView.render().el
      @$el.append container

  createCell: (options) ->
    cell = new MeetupApi.CellView(options)
    cell.on 'start', @onStart, this
    cell.on 'move', @onMove, this
    cell.on 'end', @onEnd, this
    cell

  handleTouchMove: (e) ->
    e.preventDefault()
    $elem = @getElement e.originalEvent.changedTouches
    x = $elem.attr('data-x')
    y = $elem.attr('data-y')
    @onMove e, x, y

  getElement: (changedTouches) ->
    [x, y] = [changedTouches[0].pageX, changedTouches[0].pageY]
    $.nearest({x: x, y: y}, 'div.cell')

  onStart: (e, x, y, isSelected) ->
    return if @isSelecting
    @dragStartPoint.x = x
    @dragStartPoint.y = y
    @isSelecting = true
    @newSelection = !isSelected

  onMove: (e, x, y) ->
    return unless @isSelecting
    startX = Math.min(x, @dragStartPoint.x)
    startY = Math.min(y, @dragStartPoint.y)
    endX = Math.max(x, @dragStartPoint.x)
    endY = Math.max(y, @dragStartPoint.y)

    timeValue = if @newSelection then "1" else "0"

    for column in [startX..endX]
      possible_date = @collection.at(column).getPossibleDate()
      possible_times = possible_date.get('possible_time').split ''
      for row in [startY..endY]
        possible_times[row] = timeValue
      possible_date.set 'possible_time', possible_times.join('')

  onEnd: (e) ->
    return unless @isSelecting
    @isSelecting = false
    @collection.trigger 'needsSavePossibleDates',
      success: () -> console.log "foo"

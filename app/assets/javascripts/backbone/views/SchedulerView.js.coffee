class MeetupApi.SchedulerView extends Backbone.View
  el: 'body'

  isActivated: false
  isSelecting: false

  dragStartPoint:
    x: -1
    y: -1

  events:
    'touchmove #schedule': 'handleTouchMove'

  initialize: (@options) ->
    @startRow = @collection.startRow()
    @endRow = @collection.endRow()

    rowsNumber = @endRow - @startRow + 1
    columnsNumber = @collection.length
    @widthSpan = Math.floor(12 / columnsNumber)
    @height = Math.max(80, 800 / rowsNumber)

    @render()

  render: ->
    @collection.each (eventDate) =>
      $('#dates').append $('<div />').addClass("span#{@widthSpan}").text(eventDate.getShortDate())
    for y in [@startRow..@endRow]
      @addRow y

  addRow: (y) ->
    @addTimeCell y
    container = $('<div />').attr('class', 'row-fluid')
    @collection.each (eventDate, x) =>
      @addOne eventDate, x, y, container
    @$('#schedule').append container

  addOne: (eventDate, x, y, container) ->
    possibleDate = eventDate.getPossibleDate()
    cellView = @createCell
      model: possibleDate
      x: x
      y: y
      height: @height
      widthSpan: @widthSpan
    container.append cellView.render().el

  addTimeCell: (position, height) ->
    minutes = if position % 2 == 0 then 0 else 30
    time = Date.today().set({hour: Math.floor(position / 2), minute: minutes })
    $timeCell = $('<div />').height(@height).text(time.toString 'HH:mm')
    @$('#time').append $timeCell

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
    return if @isActivated
    @dragStartPoint.x = x
    @dragStartPoint.y = y
    @isActivated = true
    @isSelecting = !isSelected
    @onMove e, x, y

  onMove: (e, x, y) ->
    return unless @isActivated
    timeValue = if @isSelecting then "1" else "0"
    for column in [x..@dragStartPoint.x]
      possible_date = @collection.at(column).getPossibleDate()
      possible_times = possible_date.get('possible_time').split ''
      for row in [y..@dragStartPoint.y]
        possible_times[row] = timeValue
      possible_date.set 'possible_time', possible_times.join('')

  onEnd: (e) ->
    return unless @isActivated
    @isActivated = false
    clearTimeout @hideSuccessTimeout if @hideSuccessTimeout?
    @collection.trigger 'needsSavePossibleDates', success: () =>
      @$('.saved').css 'visibility', 'visible'
      hideSuccess = () => @$('.saved').css 'visibility', 'hidden'
      @hideSuccessTimeout = setTimeout hideSuccess, 3000

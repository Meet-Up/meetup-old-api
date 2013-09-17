class MeetupApi.SchedulerView extends MeetupApi.CalendarWeekView
  template: JST["backbone/templates/schedule/scheduler"]

  isActivated: false
  isSelecting: false

  dragStartPoint:
    x: -1
    y: -1

  events:
    'touchmove .calendar': 'handleTouchMove'

  initialize: (@options) ->
    super @options

  createCell: (options) ->
    options.model = options.eventDate.getPossibleDate()
    cell = new MeetupApi.DynamicCellView(options)
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

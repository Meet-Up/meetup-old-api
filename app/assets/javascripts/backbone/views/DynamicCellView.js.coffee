class MeetupApi.DynamicCellView extends MeetupApi.CellView
  attributes: () ->
    attrs = super
    attrs['class'] += if @isSelected() then " selected" else " unselected"
    attrs

  events:
    'mousedown': 'notifyEvent'
    'mousemove': 'notifyEvent'
    'mouseup': 'notifyEvent'
    'touchstart': 'notifyEvent'
    'touchend': 'notifyEvent'

  initialize: (options) ->
    super options
    @model.on 'change', @updateCss, this

  isSelected: () ->
    @model.get('possible_time')[@options.y] == "1"

  updateCss: () ->
    if @isSelected()
      @$el.removeClass('unselected')
      @$el.addClass('selected')
    else
      @$el.removeClass('selected')
      @$el.addClass('unselected')

  notifyEvent: (e) ->
    e.preventDefault()
    eventName = ""
    if e.type == 'mousedown' or e.type == 'touchstart'
      return if e.type == 'mousedown' && e.which != 1
      eventName = 'start'
    else if e.type == 'mousemove'
      eventName = 'move'
    else if e.type == 'mouseup' or e.type == 'touchend'
      eventName = 'end'
    @trigger eventName, e, @options.x, @options.y, @isSelected()

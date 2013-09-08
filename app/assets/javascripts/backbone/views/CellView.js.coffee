class MeetupApi.CellView extends Backbone.View
  attributes: () ->
    cssClass = "cell span#{@options.widthSpan}"
    if @isSelected()
      cssClass += " selected"
    else
      cssClass += " unselected"

    class: cssClass
    style:
      "height: #{@options.height}px;"
    "data-x": @options.x
    "data-y": @options.y

  events:
    'mousedown': 'notifyEvent'
    'mousemove': 'notifyEvent'
    'mouseup': 'notifyEvent'
    'touchstart': 'notifyEvent'
    'touchend': 'notifyEvent'

  initialize: (options) ->
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
      eventName = 'start'
    else if e.type == 'mousemove'
      eventName = 'move'
    else if e.type == 'mouseup' or e.type == 'touchend'
      eventName = 'end'
    @trigger eventName, e, @options.x, @options.y, @isSelected()

  render: ->
    return this

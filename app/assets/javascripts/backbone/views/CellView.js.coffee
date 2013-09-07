class MeetupApi.CellView extends Backbone.View
  attributes: () ->
    cssClass = "cell"
    if @isSelected()
      cssClass += " selected"
    else
      cssClass += " unselected"

    class: cssClass
    style:
      "height: #{@options.height}px;" +
      "width: #{@options.width}px"

  events:
    'mousedown': 'notifyEvent'
    'mousemove': 'notifyEvent'
    'mouseup': 'notifyEvent'

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
    if e.type == 'mousedown'
      eventName = 'start'
    else if e.type == 'mousemove'
      eventName = 'move'
    else
      eventName = 'end'
    @trigger eventName, e, @model, @options.x, @options.y, @isSelected()

  render: ->
    @$el.html
    return this

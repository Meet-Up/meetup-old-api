class MeetupApi.CellView extends Backbone.View
  attributes: () ->
    cssClass = "cell"
    if @model.get('possible_time')[@options.index] == "1"
      cssClass += " selected"
    else
      cssClass += " unselected"

    class: cssClass
    style:
      "height: #{@options.height}px;" +
      "width: #{@options.width}px"

  events:
    'dragstart': 'notifyEvent'
    'drag': 'notifyEvent'
    'dragend': 'notifyEvent'

  initialize: (options) ->

  notifyEvent: (e) ->
    console.log e
    @trigger e.type, @model

  render: ->
    @$el.html
    return this

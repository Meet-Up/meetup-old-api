class MeetupApi.CellView extends Backbone.View
  attributes: () ->
    class: "cell span#{@options.widthSpan}"
    style:
      "height: #{@options.height}px;"
    "data-x": @options.x
    "data-y": @options.y

  initialize: (options) ->

  render: ->
    return this

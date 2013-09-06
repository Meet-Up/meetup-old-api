class MeetupApi.SchedulerView extends Backbone.View
  el: "#rootDiv"

  constructor: (@options) ->

  events:
    "dragend #rootDiv": "handleDragEnd"


  handleDragEnd: (e) ->
    console.log e

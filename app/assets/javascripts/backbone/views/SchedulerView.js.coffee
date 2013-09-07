class MeetupApi.SchedulerView extends Backbone.View
  el: '#schedule'

  initialize: (@options) ->
    @render()


  dragStartCell: [-1, -1]

  render: ->

class MeetupApi.SchedulerView extends Backbone.View
  el: '#schedule'

  initialize: (@options) ->
    @render()
    @rowsNumber = @options.rowsNumber
    @columnsNumber = @options.columnsNumber
    console.log @rowsNumber
    console.log @columnsNumber

  dragStartCell: [-1, -1]

  render: ->

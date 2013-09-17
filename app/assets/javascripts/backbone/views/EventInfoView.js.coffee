class MeetupApi.EventInfoView extends Backbone.View
  el: '.event-info'
  template: JST["backbone/templates/schedule/event_info"]

  initialize: (options) ->
    @render()

  render: ->
    @$el.html @template(@model.toJSON())
    this

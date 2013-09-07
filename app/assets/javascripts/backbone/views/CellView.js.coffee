class MeetupApi.CellView extends Backbone.View
  template: JST["backbone/templates/cell"]

  events:
    'dragstart .cell': 'onDragStart'
    'drag .cell': 'onDrag'
    'dragend #rootDiv': 'onDragEnd'

  notifyEvent: (e) ->
    console.log e
    trigger e.type, @model

  render: ->
    @$el.html @template(@model.toJSON())
    return this

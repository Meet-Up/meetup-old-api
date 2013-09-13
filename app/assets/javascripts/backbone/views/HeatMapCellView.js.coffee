class MeetupApi.HeatMapCellView extends MeetupApi.CellView
  attributes: () ->
    attrs = super
    attrs['class'] += " selected"
    attrs

  initialize: (options) ->
    super options
    @collection.on 'change', @setOpacity, this
    @setOpacity()

  setOpacity: ->
    acceptedParticipations = 0
    @collection.each (possibleDate) =>
      accepted = possibleDate.get('possible_time')[@options.y]
      acceptedParticipations += 1 if accepted == "1"
    @$el.css 'opacity', acceptedParticipations / @options.totalParticipants

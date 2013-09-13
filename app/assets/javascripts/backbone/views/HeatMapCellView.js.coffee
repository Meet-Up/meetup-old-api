class MeetupApi.HeatMapCellView extends MeetupApi.CellView
  attributes: () ->
    attrs = super
    attrs['class'] += " selected"
    attrs

  initialize: (options) ->
    super options

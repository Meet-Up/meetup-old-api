class MeetupApi.PossibleDate extends Backbone.RelationalModel
  initialize: (attributes, options) ->

class MeetupApi.PossibleDateCollection extends Backbone.Collection
  model: MeetupApi.PossibleDate


MeetupApi.PossibleDate.setup()

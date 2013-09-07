class MeetupApi.PossibleDate extends Backbone.RelationalModel
  initialize: (attributes, options) ->


MeetupApi.PossibleDate.setup()


class MeetupApi.PossibleDateCollection extends Backbone.Collection
  model: MeetupApi.PossibleDate

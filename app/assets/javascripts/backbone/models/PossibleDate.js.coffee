class MeetupApi.PossibleDate extends Backbone.RelationalModel
  defaults:
    event_id: null
    user_id: null
    possible_time: Array(48).join '0'

  initialize: (attributes, options) ->

  toJSON: () ->
    _.omit super, 'created_at', 'updated_at'


MeetupApi.PossibleDate.setup()


class MeetupApi.PossibleDateCollection extends Backbone.Collection
  model: MeetupApi.PossibleDate

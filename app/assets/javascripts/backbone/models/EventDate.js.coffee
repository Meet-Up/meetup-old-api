class MeetupApi.EventDate extends Backbone.RelationalModel
  relations: [
    type: Backbone.HasMany
    key: 'possible_dates'
    relatedModel: 'MeetupApi.PossibleDate'
    collectionType: 'MeetupApi.PossibleDateCollection'
    reverseRelation:
      key: 'event_date_id'
      includeInJSON: 'id'
  ]

  initialize: (attributes, options) ->

  parse: (response, options) ->
    response.start = new Date(response.start * 1000)
    response.end = new Date(response.end * 1000)
    response

MeetupApi.EventDate.setup()

class MeetupApi.EventDateCollection extends Backbone.Collection
  model: MeetupApi.EventDate

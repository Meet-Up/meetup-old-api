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

class MeetupApi.EventDateCollection extends Backbone.Collection
  model: MeetupApi.EventDate

MeetupApi.EventDate.setup()

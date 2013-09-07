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

  neededRows: () ->
    @length

  neededColumns: () ->
    neededColumns = 0
    date = @getFastestTime().getTime()
    end = @getLatestTime().getTime()
    while date <= end
      date += MeetupApi.Config.intervalInMs
      neededColumns += 1
    neededColumns

  getFastestTime: () ->
    minEventDate = @min (eventDate) ->
      startDate = eventDate.get 'start'
      new Date(1970, 1, 1, startDate.getHours(), startDate.getMinutes(), 0, 0)
    date = minEventDate.get 'start'
    new Date(1970, 1, 1, date.getHours(), date.getMinutes(), 0, 0)


  getLatestTime: () ->
    maxEventDate = @max (eventDate) ->
      endDate = eventDate.get 'end'
      new Date(1970, 1, 1, endDate.getHours(), endDate.getMinutes(), 0, 0)
    date = maxEventDate.get 'end'
    new Date(1970, 1, 1, date.getHours(), date.getMinutes(), 0, 0)


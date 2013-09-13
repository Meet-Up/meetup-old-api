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

  getPossibleDate: ->
    possible_date = @get('possible_dates').find (date) ->
      date.get('user_id') == App.user.get('id')
    unless possible_date?
      possible_date = new MeetupApi.PossibleDate
        event_date_id: @get 'id'
        user_id: App.user.get('id')
      @get('possible_dates').add possible_date
    possible_date

  getShortDate: ->
    start = @get 'start'
    start.toString 'MM/dd'


MeetupApi.EventDate.setup()

class MeetupApi.EventDateCollection extends Backbone.Collection
  model: MeetupApi.EventDate

  getNeededColumns: ->
    @length

  startRow: ->
    startTime = @getFastestTime()
    startTime.getHours() * 2 + (startTime.getMinutes() == 30)

  endRow: ->
    endTime = @getLatestTime()
    endTime.getHours() * 2 + (endTime.getMinutes() == 30)

  getFastestTime: ->
    minEventDate = @min (eventDate) ->
      startDate = eventDate.get 'start'
      new Date(1970, 1, 1, startDate.getHours(), startDate.getMinutes(), 0, 0)
    date = minEventDate.get 'start'
    new Date(1970, 1, 1, date.getHours(), date.getMinutes(), 0, 0)

  getLatestTime: ->
    maxEventDate = @max (eventDate) ->
      endDate = eventDate.get 'end'
      new Date(1970, 1, 1, endDate.getHours(), endDate.getMinutes(), 0, 0)
    date = maxEventDate.get 'end'
    new Date(1970, 1, 1, date.getHours(), date.getMinutes(), 0, 0)

  getPossibleDates: ->
    new MeetupApi.PossibleDateCollection(@map (eventDate) ->
      eventDate.getPossibleDate()
    )

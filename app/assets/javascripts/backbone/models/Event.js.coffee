class MeetupApi.Event extends Backbone.RelationalModel
  setEventDates: (eventDates) ->
    @set 'eventDates', eventDates
    eventDates.on 'needsSavePossibleDates', @savePossibleDates, this

  savePossibleDates: (options) ->
    new MeetupApi.BasicSaver(
      keyName: 'possible_dates'
      value: @get('eventDates').getPossibleDates()
      url: "/events/" + @get('id') + "/update_possible_dates"
    ).save options

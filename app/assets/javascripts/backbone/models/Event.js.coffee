class BasicSaver extends Backbone.Model
  toJSON: () ->
    json =
      token: $.getUrlVars()['token']
    json[@get 'keyName'] = @get('value').toJSON()
    json

  save: (options) ->
    options ?= {}
    options.url = @get 'url'
    super [], options


class MeetupApi.Event extends Backbone.RelationalModel
  setEventDates: (eventDates) ->
    @set 'eventDates', eventDates
    eventDates.on 'needsSavePossibleDates', @savePossibleDates, this

  savePossibleDates: (options) ->
    new BasicSaver(
      keyName: 'possible_dates'
      value: @get('eventDates').getPossibleDates()
      url: "/events/" + @get('id') + "/update_possible_dates"
    ).save options

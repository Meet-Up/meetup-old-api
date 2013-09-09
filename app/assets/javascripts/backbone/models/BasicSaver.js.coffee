class MeetupApi.BasicSaver extends Backbone.Model
  toJSON: () ->
    json =
      token: $.getUrlVars()['token']
    json[@get 'keyName'] = @get('value').toJSON()
    json

  save: (options) ->
    options ?= {}
    options.url = @get 'url'
    super [], options

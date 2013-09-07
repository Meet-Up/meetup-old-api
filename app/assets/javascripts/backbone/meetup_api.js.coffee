#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.MeetupApi =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

class MeetupApi.Config
  @intervalInMs: 1000 * 60 * 30


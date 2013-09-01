WebsocketRails.setup do |config|
  
  config.standalone = false

  # Change to true to enable channel synchronization between
  # multiple server instances.
  # * Requires Redis.
  config.synchronize = false
end
class EventToken < ActiveRecord::Base
  attr_accessible :event_id, :token, :user_id
end

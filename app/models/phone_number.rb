class PhoneNumber < ActiveRecord::Base
  attr_accessible :phone_number

  belongs_to :user
end

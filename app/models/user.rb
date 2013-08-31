class User < ActiveRecord::Base
	has_many :possible_dates
	attr_accessible :name, :token
end

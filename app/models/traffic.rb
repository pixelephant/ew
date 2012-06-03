class Traffic < ActiveRecord::Base
	has_many :travel_offers

	attr_accessible :id, :name
end

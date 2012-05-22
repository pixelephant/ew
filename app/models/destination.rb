class Destination < ActiveRecord::Base
	has_and_belongs_to_many :travel_offers

	has_one :city
	has_one :region
	has_one :country
end

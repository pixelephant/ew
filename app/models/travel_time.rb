class TravelTime < ActiveRecord::Base
	belongs_to :travel_offer
	has_many :pre_bookings
	has_many :child_prices
	has_many :optional_fees
	has_and_belongs_to_many :inprices
end

class TravelTime < ActiveRecord::Base
	belongs_to :travel_offer
	has_many :pre_bookings
	has_many :child_prices
	has_many :optional_fees
	has_and_belongs_to_many :inprices
	has_and_belongs_to_many :outprices
	belongs_to :city, :foreign_key => "departure_city_id"
	has_many :orders

	attr_accessible :id, :travel_offer_id, :from_date, :to_date, :price_expire, :price_measure, :night, :day, :price, :discount, :service, :bed, :reservation_fee, :transfer_fee, :service_fee, :visa_fee, :airport_tax, :storno_insurance, :bpp, :kerosene_charge, :individual, :travel_time_type_name, :travel_time_type_code, :departure_city_id, :note
end

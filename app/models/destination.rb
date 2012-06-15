class Destination < ActiveRecord::Base
	has_and_belongs_to_many :travel_offers

	belongs_to :city
	belongs_to :region
	belongs_to :country

	accepts_nested_attributes_for :travel_offers

	attr_protected
	#attr_accessible :id, :country_id, :region_id, :city_id
end

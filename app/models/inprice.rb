class Inprice < ActiveRecord::Base
	has_and_belongs_to_many :travel_offers
	has_and_belongs_to_many :travel_times

	attr_accessible :id, :name
end

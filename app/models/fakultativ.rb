class Fakultativ < ActiveRecord::Base
	belongs_to :travel_offer

	attr_accessible :id, :title, :description, :length, :price
end

class Board < ActiveRecord::Base
	belongs_to :travel_offer

	attr_accessible :id, :name
end

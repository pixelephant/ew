class Description < ActiveRecord::Base
	belongs_to :travel_offer

	attr_accessible :id, :name, :description
end

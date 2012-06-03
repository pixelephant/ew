class City < ActiveRecord::Base
	belongs_to :country
	belongs_to :region
	belongs_to :destination

	attr_accessible :id, :name, :region_id, :country_id
end

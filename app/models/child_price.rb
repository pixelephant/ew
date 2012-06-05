class ChildPrice < ActiveRecord::Base
	belongs_to :travel_time

	attr_accessible :id, :age_from, :age_to, :bed_type, :price_type, :price
end

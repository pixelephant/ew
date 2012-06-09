class OptionalFee < ActiveRecord::Base
	belongs_to :travel_time

	attr_accessible :id, :name, :price, :price_type, :optional, :discount, :category_id, :age_from, :age_to, :valid_from, :valid_to
end

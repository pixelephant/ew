class Image < ActiveRecord::Base
	belongs_to :travel_offer

	attr_accessible :id, :file_name, :travel_offer_id
end

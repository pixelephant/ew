class Image < ActiveRecord::Base
	belongs_to :travel_offer

	mount_uploader :file_name, ImageUploader

	attr_accessible :id, :file_name, :travel_offer_id, :file_name_cache, :remove_file_name
end

class Image < ActiveRecord::Base
	belongs_to :travel_offer

	mount_uploader :own_image_file, ImageUploader

	attr_accessible :id, :file_name, :own_image_file, :travel_offer_id, :own_image_file_cache, :remove_own_image_file
end

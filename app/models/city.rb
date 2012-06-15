class City < ActiveRecord::Base
	belongs_to :country
	belongs_to :region
	has_many :destinations

	attr_accessible :id, :name, :region_id, :country_id

	default_scope :order => 'name ASC'
end

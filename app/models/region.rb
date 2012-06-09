class Region < ActiveRecord::Base
	belongs_to :destination

	has_many :cities
	belongs_to :country
	has_many :skiregions

	attr_accessible :id, :name, :country_id

	default_scope :order => 'name ASC'
end

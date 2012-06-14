class Country < ActiveRecord::Base
	belongs_to :destination

	has_many :regions
	has_many :cities
	has_many :skiregions
	has_many :goods

	attr_accessible :id, :name

	default_scope :order => 'position DESC, name ASC'

	def travel_offers_count
		TravelOffer.joins(:destinations).where(:destinations => {:country_id => self.id}).count
	end
end

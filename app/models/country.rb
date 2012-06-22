class Country < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, :use => :slugged

	has_many :destinations

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

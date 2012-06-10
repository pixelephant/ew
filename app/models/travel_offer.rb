class TravelOffer < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name_and_id, :use => :slugged

	has_and_belongs_to_many :destinations
	has_and_belongs_to_many :program_types
	has_and_belongs_to_many :traveldays
	has_and_belongs_to_many :inprices
	has_and_belongs_to_many :outprices
	has_and_belongs_to_many :travel_attributes

	has_many :images, :dependent => :destroy
	has_many :descriptions, :dependent => :destroy
	has_many :fakultativs, :dependent => :destroy
	has_many :travel_times, :dependent => :destroy
	
	belongs_to :board
	belongs_to :traffic
	belongs_to :skiregion

	accepts_nested_attributes_for :destinations
	accepts_nested_attributes_for :program_types
	accepts_nested_attributes_for :traveldays

	attr_accessible :id, :md5, :partner_id, :travel_name, :szallas_name, :category_standard, :category_aleph, :gallery_url, :board_id, :traffic_id

	def closest_travel_time
		TravelTime.where("travel_offer_id = #{self.id} AND DATE(from_date) > DATE(NOW())").order("from_date ASC").first
	end

	def min_price
		t = TravelTime.where("travel_offer_id = #{self.id} AND DATE(from_date) > DATE(NOW())").order("price ASC").first
		t.nil? ? 0 : t.price
	end

	def similar_offers
		TravelOffer.joins(:travel_times, :program_types).where(["board_id = ? AND traffic_id = ? AND category_standard = ? AND travel_offers.id <> ? AND DATE(from_date) > DATE(NOW())", self.board_id, self.traffic_id, self.category_standard, self.id]).group('travel_offers.id').limit(4)
	end

	def name_and_id
    "#{travel_name}-#{id}"
  end
end

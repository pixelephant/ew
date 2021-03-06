#encoding: utf-8

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
	belongs_to :partner

	#accepts_nested_attributes_for :destinations
	# accepts_nested_attributes_for :program_types
	# accepts_nested_attributes_for :traveldays
	# accepts_nested_attributes_for :images
	# accepts_nested_attributes_for :travel_attributes
	# accepts_nested_attributes_for :inprices
	# accepts_nested_attributes_for :outprices
	# accepts_nested_attributes_for :descriptions
	# accepts_nested_attributes_for :fakultativs
	# accepts_nested_attributes_for :travel_times

	#attr_accessible :id, :md5, :partner_id, :travel_name, :szallas_name, :category_standard, :category_aleph, :gallery_url, :board_id, :traffic_id,
	attr_protected

	def closest_travel_time
		t = TravelTime.where("travel_offer_id = #{self.id}").order("from_date ASC").first
		t = self.travel_times.first if t.nil?
		return t
		# TravelTime.where("travel_offer_id = #{self.id} AND DATE(from_date) > DATE(NOW())").order("from_date ASC").first
	end

	def closest_travel_time_to_date
		TravelTime.where("travel_offer_id = #{self.id} AND DATE(from_date) > DATE(#{session[:from]})").order("from_date ASC").first
	end

	def min_price
		# t = TravelTime.where("travel_offer_id = #{self.id} AND DATE(from_date) > DATE(NOW())").order("price ASC").first
		t = TravelTime.where("travel_offer_id = #{self.id}").order("price ASC").first
		t.nil? ? 0 : t.price
	end

	def min_price_measure
		# t = TravelTime.where("travel_offer_id = #{self.id} AND DATE(from_date) > DATE(NOW())").order("price ASC").first
		t = TravelTime.where("travel_offer_id = #{self.id}").order("price ASC").first
		t.nil? ? '' : t.price_measure
	end

	def similar_offers
		TravelOffer.joins(:travel_times, :program_types).where(["board_id = ? AND traffic_id = ? AND category_standard = ? AND travel_offers.id <> ? AND DATE(from_date) > DATE(NOW())", self.board_id, self.traffic_id, self.category_standard, self.id]).group('travel_offers.id').limit(4)
	end

	def name_and_id
    "#{travel_name}-#{id}"
  end

  def ribbon
  	ribbon = []
  	if self.special == 1
  		ribbon[0] = 'special '
  		ribbon[1] = 'Akciós'
  	end

  	if self.updated_at > (Time.now - 7.days).to_date
  		ribbon[0] = 'new '
  		ribbon[1] = 'Új'
  	end

  	if self.closest_travel_time && self.closest_travel_time.from_date.to_date < (Time.now + 14.days).to_date
  		ribbon[0] = 'lastminute '
  		ribbon[1] = 'Last minute'
  	end

  	return ribbon
  end

end

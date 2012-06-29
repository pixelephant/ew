class TravelTime < ActiveRecord::Base
	after_save :expire_cache
	after_destroy :expire_cache

	extend FriendlyId
  friendly_id :travel_time_slug, :use => :slugged

	belongs_to :travel_offer
	has_many :pre_bookings
	has_many :child_prices
	has_many :optional_fees
	has_and_belongs_to_many :inprices
	has_and_belongs_to_many :outprices
	belongs_to :city, :foreign_key => "departure_city_id"
	has_many :orders

	#attr_accessible :id, :travel_offer_id, :from_date, :to_date, :price_expire, :price_measure, :night, :day, :price, :discount, :service, :bed, :reservation_fee, :transfer_fee, :service_fee, :visa_fee, :airport_tax, :storno_insurance, :bpp, :kerosene_charge, :individual, :travel_time_type_name, :travel_time_type_code, :departure_city_id, :note, :slug
	attr_protected

	accepts_nested_attributes_for :inprices
	accepts_nested_attributes_for :outprices
	accepts_nested_attributes_for :child_prices
	accepts_nested_attributes_for :optional_fees
	accepts_nested_attributes_for :pre_bookings

	def travel_time_slug
    "#{from_date}-#{id}"
  end

  def expire_cache
  	Rails.cache.delete("my_object:#{self.id}")
  end
end

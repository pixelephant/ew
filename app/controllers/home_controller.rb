#encoding: utf-8
class HomeController < ApplicationController
	layout "application"

	caches_page :index

	def index
		@regions = []
		@cities = []
		
		@specials = TravelOffer.where(:special => 1).limit(9)
		# @specials = Rails.cache.fetch("home_specials", :expires_in => 24.hours) { TravelOffer.where(:special => 1).limit(9) }
		#@popular = Destination.joins(:travel_offers).select("destinations.country_id").order("travel_offers.click DESC").group("destinations.country_id").limit(5)
		@popular = Country.where(:name => ["Dubai", "Kuba", "Törökország", "Görögország", "Egyiptom", "Horvátország", "Tunézia", "Spanyolország", "Olaszország", "Maldív-szigetek", "Seychelle szigetek",  "Mauritius", "Amerikai Egyesült Államok", "Bangkok", "Thaiföld"])
		# @popular = Rails.cache.fetch("home_popular", :expires_in => 24.hours) { Country.where(:name => ["Dubai", "Kuba", "Törökország", "Görögország", "Egyiptom", "Horvátország", "Tunézia", "Spanyolország", "Olaszország", "Maldív-szigetek", "Seychelle szigetek",  "Mauritius", "Amerikai Egyesült Államok", "Bangkok", "Thaiföld"]) }

		render "index"
	end

end

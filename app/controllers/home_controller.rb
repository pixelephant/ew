#encoding: utf-8
class HomeController < ApplicationController
	layout "application"

	def index
		@regions = []
		@cities = []
		
		@specials = TravelOffer.where(:special => 1).limit(9)
		#@popular = Destination.joins(:travel_offers).select("destinations.country_id").order("travel_offers.click DESC").group("destinations.country_id").limit(5)
		@popular = Country.where(:name => ["Dubai", "Kuba", "Törökország", "Görögország", "Egyiptom", "Horvátország", "Tunézia", "Spanyolország", "Olaszország", "Maldív-szigetek", "Seychelle szigetek",  "Mauritius", "Amerikai Egyesült Államok", "Bangkok", "Thaiföld"])

		render "index"
	end

end

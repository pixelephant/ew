class TripController < ApplicationController
	layout "application"

	def index
		render "index"
	end

	def show
		@travel_offer = TravelOffer.find(params[:id])

		params[:from_date] ? @closest_travel_time = @travel_offer.travel_times.find_by_slug(params[:from_date]) : @closest_travel_time = @travel_offer.closest_travel_time
		@country = Country.find(@travel_offer.destinations.first.country_id)
		@region = Region.find(@travel_offer.destinations.first.region_id)
		@skiregion = @travel_offer.skiregion
		@departure_city = @closest_travel_time.city ? @closest_travel_time.city.name : ''
		@images = @travel_offer.images.limit(5)
		@gallery = @travel_offer.gallery_url.to_s
		@travel_times = @travel_offer.travel_times.where('(DATE(travel_times.from_date) > DATE(NOW())) AND travel_times.id <> ' + @closest_travel_time.id.to_s).order("travel_times.from_date ASC")
		@leiras = @travel_offer.descriptions.where(:name => 'Fekvese').first.description.to_s.html_safe
		@artablazat = @travel_offer.descriptions.where(:name => 'Artablazat').first.description.to_s.html_safe
		@inprices = @travel_offer.inprices
		@outprices = @travel_offer.outprices
		@fakultativs = @travel_offer.fakultativs
		@traveldays = @travel_offer.traveldays

		if @travel_offer.gmap.blank?
			@lat = @travel_offer.destinations.first.city.lat if @travel_offer.destinations.first.city
			@long = @travel_offer.destinations.first.city.long if @travel_offer.destinations.first.city
		else
			coor = @travel_offer.gmap.split(",")
			@lat = coor[0]
			@long = coor[1]
		end

		@prebooking = @closest_travel_time.pre_bookings.where("end_date > DATE(NOW())").order("end_date ASC")
		@child_prices = @closest_travel_time.child_prices
		@good_to_knows = @country.goods

		@similar_offers = @travel_offer.similar_offers
		@travel_attributes = @travel_offer.travel_attributes

		@travel_offer.click = (@travel_offer.click.to_i + 1)
		@travel_offer.save

		@title = @travel_offer.travel_name + ", " + @country.name + " - "
		@description = @leiras

		render "show"
	end

end

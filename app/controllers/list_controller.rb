class ListController < ApplicationController
	layout "application"

	def index
		@traveloffers = TravelOffer.page(params[:page])
		render "index"
	end

end

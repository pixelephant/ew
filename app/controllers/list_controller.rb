class ListController < ApplicationController
	layout "application"

	def index
		@traveloffers = TravelOffer.page(params[:page]).per(3)
		render "index"
	end

end

class HomeController < ApplicationController
	layout "application"

	def index
		@regions = []
		@cities = []
		
		render "index"
	end

end

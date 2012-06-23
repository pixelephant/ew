class ExclusiveController < ApplicationController
	layout "application"

	def hungaroring
		render "hungaroring"
	end

	def fcbarcelona
		render "barcelona"
	end

end

class InsuranceController < ApplicationController
	layout "application"

	def index
		@title = "Utasbiztosítások - "
		@description = "Külföldi és belföldi utazás mellé célszerű utasbiztosítást kötni"
		render "index"
	end

end

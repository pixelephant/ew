#encoding: utf-8
class InsuranceController < ApplicationController
	layout "application"

	caches_page :index

	def index
		@title = "Utasbiztosítások - "
		@description = "Külföldi és belföldi utazás mellé célszerű utasbiztosítást kötni"
		render "index"
	end

end

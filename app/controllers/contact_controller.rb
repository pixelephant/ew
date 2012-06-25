class ContactController < ApplicationController
	layout "application"

	caches_page :index

	def index
		render "index"
	end

end

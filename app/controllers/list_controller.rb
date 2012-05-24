class ListController < ApplicationController
	layout "application"

	def index

		@program_types = ProgramType.all
		order_by = 'travel_offers.created_at'

		params[:ord] == 'csokkeno' ? ord = 'desc' : ord = 'asc'

		case params[:sort]
			when 'legnepszerubbek' then order_by = 'travel_times.click'
			when 'legujabbak' then order_by = 'travel_offers.created_at'
			when 'arnovekvo' then order_by = 'travel_times.price'
			when 'arcsokkeno' then order_by = 'travel_times.price'
			when 'utneve' then order_by = 'travel_offers.travel_name'
		end

		traveloffers_array = TravelOffer.find(:all, :joins => :travel_times, :select => "travel_offers.*", :order => order_by + " " + ord, :group => "travel_offers.id" )
		#@traveloffers = Kaminari.paginate_array(@traveloffers_array).page(params[:page])
		@traveloffers = Kaminari.paginate_array(traveloffers_array).page(params[:page])
		render "index"
	end

end

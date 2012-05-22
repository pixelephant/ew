class ListController < ApplicationController
	layout "application"

	def index
		order_by = 'created_at'

		case params[:sort]
			when 'legnepszerubbek' then order_by = 'id'
			when 'legujabbak' then order_by = 'created_at'
			when 'arnovekvo' then order_by = 'price'
			when 'arcsokkeno' then order_by = 'price'
			when 'utneve' then order_by = 'travel_name'
		end

		@traveloffers = TravelOffer.order(order_by).page(params[:page])
		render "index"
	end

end

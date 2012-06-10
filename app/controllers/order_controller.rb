class OrderController < ApplicationController
	layout "application"

	def index
		@travel_time = TravelTime.find(params[:id])
		@travel_offer = TravelOffer.find(@travel_time.travel_offer_id)
		render "index"
	end

	def personalized
		render "personalized"
	end

	def thankyou

		note = params[:com]
		email = params[:email]
		adult = params[:head]
		name = params[:name]
		phone = params[:prefix] + "/" + params[:number]
		tt = params[:traveltime]
		note = ("EGYEDI: " + note) if tt == 0

		if Order.create(:name => name, :adult => adult, :email => email, :note => note, :phone => phone, :travel_time_id => tt).save
			render "thankyou"
		else
			render "index"
		end
	end

end

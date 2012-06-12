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
		to = TravelTime.where(:travel_offer_id => tt).first
		partner_name = to.partner.name
		travel_text = "Utazás: " + to.travel_name.to_s + " | Időpontja: " + tt.from_date.to_s " - " + tt.to_date.to_s + " | Módja: " + to.traffic.name + " | Ellátás: " + to.board.name
		note = ("EGYEDI: " + note) if tt == 0

		if Order.create(:name => name, :adult => adult, :email => email, :note => note, :phone => phone, :travel_time_id => tt, :partner_name => partner_name).save
			render "thankyou"
		else
			render "index"
		end
	end

end

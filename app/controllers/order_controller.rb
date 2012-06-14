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
		tt = TravelTime.find(params[:traveltime])
		to = TravelOffer.find(tt.travel_offer_id)
		partner_name = to.partner.name
		
		inprices = ""
		to.inprices.each do |ip|
			inprices << (ip.name.to_s + ",")
		end
		tt.inprices.each do |ip|
			inprices << (ip.name.to_s + ",")
		end

		outprices = ""
		to.outprices.each do |op|
			outprices << (op.name.to_s + ",")
		end
		tt.outprices.each do |ip|
			outprices << (op.name.to_s + ",")
		end

		travel_text = "Utazás: " + to.travel_name.to_s + " <br/> Időpontja: " + tt.from_date.to_s + " - " + tt.to_date.to_s + " <br/> Módja: " + to.traffic.name.to_s + " <br/> Ellátás: " + to.board.name.to_s + " <br/> Ára: " + to.price.to_s + to.price_measure.to_s + "<br/> Szállás típusa: " + to.category_aleph.to_s + "<br /> Az ár tartalmazza: " + inprices.to_s "<br />Az ár nem tartalmazza: " + outprices.to_s
		note = ("EGYEDI: " + note) if tt == 0

		if Order.create(:name => name, :adult => adult, :email => email, :note => note, :phone => phone, :travel_time_id => tt, :partner_name => partner_name, :travel_text => travel_text).save
			render "thankyou"
		else
			flash[:notice] = "Nem sikerült rögzíteni a megrendelést, kérjük próbálja újra!"
			render "index"
		end
	end

end

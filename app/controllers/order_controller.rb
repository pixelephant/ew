# encoding: UTF-8
class OrderController < ApplicationController
	layout "application"

	def index
		@travel_time = TravelTime.find(params[:id])
		@travel_offer = TravelOffer.find(@travel_time.travel_offer_id)
		render "index"
	end

	def personalized
		if params[:id]
			@full_personalized = false
			@travel_time = TravelTime.find(params[:id])
			@travel_offer = TravelOffer.find(@travel_time.travel_offer_id)
		else
			@full_personalized = true
		end
		render "personalized"
	end

	def thankyou

		note = params[:com]
		email = params[:email]
		adult = params[:head]
		children = params[:children]
		name = params[:name]
		phone = params[:prefix] + "/" + params[:number]

		unless params[:traveltime] == '0'
			tt = TravelTime.find(params[:traveltime])
			to = TravelOffer.find(tt.travel_offer_id)
			partner_name = to.partner ? to.partner.name : ''
			
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

			children_pr = ""
			tt.child_prices.each do |cp|
				children_pr << ("Kortól: " + cp.age_from.to_s + ", Korig: " + cp.age_to.to_s + ", Kedvezmény: " + cp.price.to_s + cp.price_type.to_s + ", Elhelyezés: " + cp.bed_type)
			end

			pre_bookings = ""
			tt.pre_bookings.where("end_date > DATE(NOW())").each do |pb|
				pre_bookings << ("Kedvezmény érvényes: " + pb.start_date.to_s + "-" + pb.end_date.to_s + ", mértéke: " + pb.amount.to_s + pb.amount_type.to_s + ". Szöveges leírás: " + pb.description.to_s)
			end

			travel_text = "Utazás: " + to.travel_name.to_s + " \nIdőpontja: " + tt.from_date.to_s + " - " + tt.to_date.to_s + " \nMódja: " + to.traffic.name.to_s + " \nEllátás: " + to.board.name.to_s + " \nÁra: " + tt.price.to_s + tt.price_measure.to_s + "\nSzállás típusa: " + to.category_aleph.to_s + "\nAz ár tartalmazza: " + inprices.to_s + "\nAz ár nem tartalmazza: " + outprices.to_s
			travel_text << ("\nGyermek kedvezmény: " + children_pr) unless children_pr.blank?
			travel_text << ("\nElőfoglalási kedvezmény: " + pre_bookings) unless pre_bookings.blank?

			tt_id = tt.id
		else
			tt_id = 0
			partner_name = ''
		end

		note = ("EGYEDI: " + note) if tt == 0

		if o = Order.create(:name => name, :adult => adult, :children => children, :email => email, :note => note, :phone => phone, :travel_time_id => tt_id, :partner_name => partner_name, :travel_text => travel_text)
			UserMailer.travel_order(o.id).deliver	
			UserMailer.travel_order_thankyou(o.id).deliver
			render "thankyou"
		else
			flash[:notice] = "Nem sikerült rögzíteni a megrendelést, kérjük próbálja újra!"
			render "index"
		end
	end

end

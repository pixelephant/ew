namespace :import do

	require 'nokogiri'
	require 'open-uri'

	include ActionView::Helpers::SanitizeHelper
  
  task :inittraveloffers => :environment do

  	desc "Processing xml file containing travel offers"
    # get file
		unchanged_counter = 0
		offer_counter = 0
		puts "Processing file"
		
		doc = Nokogiri::XML(File.open("public/xml_minta.xml"))

		doc.css("traveloffer").each_with_index do |traveloffer, i|

			puts traveloffer.css("md5").inner_text

			md5 = traveloffer.css("md5").inner_text
			if TravelOffer.where(:md5 => md5).any?
				unchanged_counter += 1
			else
				
				t = TravelOffer.new
				t.md5 = md5
				t.id = traveloffer.css("id").inner_text
				t.partner_id = traveloffer.css("partnerid").inner_text
				t.travel_name = traveloffer.css("travel_name").inner_text
				t.szallas_name = traveloffer.css("szallas_name").inner_text
				t.category_standard = traveloffer.css("category_standard").inner_text
				t.category_aleph = traveloffer.css("category_aleph").inner_text
				t.board_id = traveloffer.css("board").inner_text
				t.gallery_url = traveloffer.css("gallery").attribute("url").to_s
				t.gmap = traveloffer.css("gmap").inner_text
				t.traffic_id = traveloffer.css("traffic").inner_text

				traveloffer.css("destinations destination").each do |dest|

					country = dest.attribute("country").to_s
					region = dest.attribute("region").to_s
					city = dest.attribute("city").to_s

					d = Destination.where(:country_id => country, :region_id => region, :city_id => city).limit(1).first

					t.destinations << d

					puts 'Traveloffer: ' + i.to_s
				end

				traveloffer.css("program_type").each do |program_type|
					t.program_types << ProgramType.find(program_type.inner_text)
				end

				traveloffer.css("attribute").each do |attribute|
					t.attributes << Attribute.find(attribute.inner_text)
				end

				traveloffer.css("travelday").each do |travelday|
					t.traveldays << Travelday.find(travelday.inner_text)
				end

				traveloffer.css("inprices inprice").each do |inprice|
					t.inprices << Inprice.find(inprice.inner_text)
				end

				traveloffer.css("outprices outprice").each do |outprice|
					t.outprices << Outprice.find(outprice.inner_text)
				end

				traveloffer.css("kepfilenev").each do |image|
					t.images.new(:file_name => image.inner_text)
				end

				traveloffer.css("description").each do |description|
					t.descriptions.new(:name => description.attribute("name").to_s, :description => description.inner_text)
				end

				#Nincsenek fakultativ utak a sample-ben
				traveloffer.css("fakultativ_programok fakultativ").each do |fakultativ|
				 	t.fakultativs.new(:title => fakultativ.css("cim").inner_text, :description => fakultativ.css("leiras").inner_text, :length => fakultativ.attribute("idotartam").to_s, :price => fakultativ.attribute("ar").to_s)
				end

				traveloffer.css("idopontok idopont").each do |travel_time|
					tt = t.travel_times.new(
						:id => travel_time.attribute("id").to_s,
						:from_date => travel_time.attribute("fromdate").to_s,
						:to_date => travel_time.attribute("todate").to_s,
						:price_expire => travel_time.attribute("lejar_ar").to_s,
						:price_measure => travel_time.attribute("szobakalk").to_s,
						:night => travel_time.attribute("ej").to_s,
						:day => travel_time.attribute("nap").to_s,
						:price => travel_time.attribute("ar").to_s,
						:discount => travel_time.attribute("akcios").to_s,
						:service => travel_time.attribute("ellatas").to_s,
						:bed => travel_time.attribute("agyszam").to_s,
						:reservation_fee => travel_time.attribute("foglalasi_dij").to_s,
						:transfer_fee => travel_time.attribute("transzfer_dij").to_s,
						:service_fee => travel_time.attribute("szervizdij").to_s,
						:visa_fee => travel_time.attribute("vizum_dij").to_s,
						:airport_tax => travel_time.attribute("repteri_illetek").to_s,
						:storno_insurance => travel_time.attribute("storno_biztositas").to_s,
						:bpp => travel_time.attribute("bpp").to_s,
						:kerosene_charge => travel_time.attribute("kerozin_potdij").to_s,
						:individual => travel_time.attribute("egyeni_idopont").to_s,
						:travel_time_type_name => travel_time.css("idopont_tipus").inner_text,
						:travel_time_type_code => travel_time.css("idopont_tipuskod").inner_text,
						:departure_city_id => travel_time.css("departure_city").inner_text,
						:note => travel_time.css("megjegyzes").inner_text
						)
					travel_time.css("opcio").each do |opcio|
						tt.optional_fees.new(
							:name => opcio.css("name").inner_text,
							:price => opcio.attribute("ar"),
							:price_type => opcio.attribute("ar_tipus"),
							:optional => opcio.attribute("opcios"),
							:category_id => opcio.attribute("category"),
							:age_from => opcio.attribute("eletkor_tol"),
							:age_to => opcio.attribute("eletkor_ig"),
							:valid_from => opcio.attribute("ervenyes_tol"),
							:valid_to => opcio.attribute("ervenyes_ig")
						)
					end

					travel_time.css("inprice").each do |inprice|
						tt.inprices << Inprice.find(inprice.inner_text).limit(1)
					end

					travel_time.css("outprice").each do |outprice|
						tt.outprices << Outprice.find(outprice.inner_text).limit(1)
					end

					travel_time.css("elofoglalas").each do |prebooking|
						tt.pre_bookings << PreBooking.new(
								:start_date => prebooking.attribute("datum_kezd").to_s,
								:end_date => prebooking.attribute("datum_vege").to_s,
								:type => prebooking.attribute("tipus").to_s,
								:amount => prebooking.css("osszeg").inner_text,
								:description => prebooking.css("szoveg").inner_text
							)
					end

					travel_time.css("gyerek_ar").each do |child_price|
						tt.child_prices << ChildPrice.new(
								:age_from => child_price.attribute("kortol").to_s,
								:age_to => child_price.attribute("korig").to_s,
								:bed_type => child_price.attribute("agytipus").to_s,
								:price_type => child_price.attribute("ar_tipus").to_s,
								:price => child_price.attribute("ar").to_s
							)
					end

				end

				#puts traveloffer.css("gmap").inner_text
				
				begin t.save!
					puts "Offer saved successfully"
				rescue Exception => e
	  			puts "Error during save process: #{e.class}"
				end

			end

			offer_counter = (i+1)

		end
    
		puts "Offers found: " << offer_counter.to_s
		puts "Offers processed: " << (offer_counter.to_i - unchanged_counter.to_i).to_s
		puts "Offers unchanged:" << unchanged_counter.to_s
  end

  task :deletedoffers => :environment do

  	desc "Processing xml file containing travel offers"
    # get file
		puts "Processing file"
		
		doc = Nokogiri::XML(File.open("public/xmlallgen_megszunt.xml"))

		doc.css("traveloffers traveloffer").each_with_index do |traveloffer, i|
			id = traveloffer.attribute("id").to_s
			TravelOffer.delete(id)
		end
		puts "Travel offers removed: " + (i+1).to_s
  end

end

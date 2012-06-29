#encoding: utf-8

namespace :parse do

	require 'nokogiri'

	task :pullparse, [:file_name] => :environment do |t, args|

		desc "Processing xml file containing travel offers"
    # get file
    args.with_defaults(:file_name => "xmlallgen_osszes.xml")
    time = Time.now
		changed_counter = 0
		offer_counter = 0
		total_count = 0
		counter = 0
		new_offer = 0
		puts "Processing file"

		md5 = ''
		
		doc = Nokogiri::XML::Reader(File.open("public/" + args.file_name))
		# doc = Nokogiri::XML::Reader(File.open("public/xml_minta.xml"))

		time = Time.now

		doc.each do |node|
			# #puts "Name: " + node.name.to_s + ", Value: " + node.value.to_s + ", Attributes: " + node.attributes.to_s + ", Type: " + node.node_type.to_s

			# #puts node.node_type.to_s
			# #puts node.name.to_s

			if node.name.to_s == 'traveloffers' && node.node_type.to_s == '1'
				total_count = node.attribute("count")
				puts "Összes út: " + total_count.to_s
			end


			if node.name.to_s == 'traveloffer' && node.node_type.to_s == '1'
				new_offer = 1
			end
			if node.name.to_s == "md5" && node.node_type.to_s == '1'
				#puts node.name.to_s + ": " + node.inner_xml.to_s
				md5 = node.inner_xml.to_s
			end
			if node.name.to_s == "id" && node.node_type.to_s == '1'
				# #puts "Name: " + node.name.to_s + ", Value: " + node.value.to_s + ", Attributes: " + node.attributes.to_s + ", Type: " + node.node_type.to_s
				#puts node.name.to_s + ": " + node.inner_xml.to_s
				TravelOffer.destroy(node.name.to_i) if TravelOffer.exists?(node.inner_xml.to_i)
				unless new_offer == 0 || TravelOffer.exists?(node.inner_xml.to_i)
					t = TravelOffer.new
					t.id = node.inner_xml.to_s
					t.md5 = md5
					puts "Új út!  " + node.inner_xml.to_s
				else
					puts "Nem új út!"
					new_offer = 0
				end
			end
			if new_offer == 1
				if node.name.to_s == "partnerid" && node.node_type.to_s == '1'
					#puts node.name.to_s + ": " + node.inner_xml.to_s
					t.partner_id = node.inner_xml.to_s
				end
				if node.name.to_s == "travel_name" && node.node_type.to_s == '1'
					#puts node.name.to_s + ": " + node.inner_xml.to_s
					t.travel_name = node.inner_xml.to_s[9..-4]
				end
				if node.name.to_s == "szallas_name" && node.node_type.to_s == '1'
					#puts node.name.to_s + ": " + node.inner_xml.to_s
					t.szallas_name = node.inner_xml.to_s[9..-4]
				end
				if node.name.to_s == "destinations" && node.node_type.to_s == '1'
					#puts "Destinations:"
					# node.read
					until (node.name.to_s == "destinations" && node.node_type.to_s == "15")
						node.read
						if node.name.to_s == "destination" && node.node_type.to_s == '1'
							#puts "Country: " + node.attribute("country") + ", region: " + node.attribute("region") + ", city: " + node.attribute("city")
							t.destinations << Destination.find_or_create_by_country_id_and_region_id_and_city_id(node.attribute("country"),node.attribute("region"),node.attribute("city"))
						end
					end
				end
				
				if node.name.to_s == "skiregion" && node.node_type.to_s == '1'
					#puts "Skiregion: " + node.attribute("skiregion").to_s
					t.skiregion_id = node.attribute("skiregion").to_s
				end
				if node.name.to_s == "category_standard" && node.node_type.to_s == '1'
					#puts "Category st: " + node.inner_xml.to_s
					t.category_standard = node.inner_xml.to_s
				end
				if node.name.to_s == "category_aleph" && node.node_type.to_s == '1'
					#puts "Category aleph: " + node.inner_xml.to_s
					t.category_aleph = node.inner_xml.to_s[9..-4]
				end
				if node.name.to_s == "program_type" && node.node_type.to_s == '1'
					#puts "Program: " + node.inner_xml.to_s
					t.program_types << ProgramType.find(node.inner_xml.to_s) if ProgramType.exists?(node.inner_xml.to_s)
				end
				if node.name.to_s == "attribute" && node.node_type.to_s == '1'
					#puts "Attribute: " + node.inner_xml.to_s
					t.travel_attributes << TravelAttribute.find(node.inner_xml.to_s) if TravelAttribute.exists?(node.inner_xml.to_s) 
				end
				if node.name.to_s == "traffic" && node.node_type.to_s == '1'
					#puts "Traffic: " + node.inner_xml.to_s
					t.traffic_id = node.inner_xml.to_s
				end
				if node.name.to_s == "travelday" && node.node_type.to_s == '1'
					#puts "Travelday: " + node.inner_xml.to_s
					t.traveldays << Travelday.find(node.inner_xml.to_s) if Travelday.exists?(node.inner_xml.to_s)
				end
				if node.name.to_s == "board" && node.node_type.to_s == '1'
					#puts "Board: " + node.inner_xml.to_s
					t.board_id = node.inner_xml.to_s
				end
				if node.name.to_s == "inprice" && node.node_type.to_s == '1'
					#puts "Inprice: " + node.inner_xml.to_s
					t.inprices << Inprice.find(node.inner_xml.to_s) if Inprice.exists?(node.inner_xml.to_s)
				end
				if node.name.to_s == "outprice" && node.node_type.to_s == '1'
					#puts "Outprice: " + node.inner_xml.to_s
					t.outprices << Outprice.find(node.inner_xml.to_s) if Outprice.exists?(node.inner_xml.to_s)
				end
				if node.name.to_s == "gallery" && node.node_type.to_s == '1'
					#puts "Gallery: " + node.attribute("url").to_s
					t.gallery_url = node.attribute("url").to_s
				end
				if node.name.to_s == "kepfilenev" && node.node_type.to_s == '1'
					#puts "Kep: " + node.inner_xml.to_s
					t.images.new(:file_name => node.inner_xml.to_s[9..-4])
				end
				if node.name.to_s == "gmap" && node.node_type.to_s == '1'
					#puts "gmap: " + node.inner_xml.to_s
					t.gmap = node.inner_xml.to_s[9..-4]
				end
				if node.name.to_s == "description" && node.node_type.to_s == '1'
					#puts "Name: " + node.attribute("name").to_s + "Leiras: " + node.inner_xml.to_s
					t.descriptions.new(:name => node.attribute("name").to_s, :description => node.inner_xml.to_s[9..-4])
				end
				#Fakultativ
				if node.name.to_s == "fakultativ" && node.node_type.to_s == '1'
					#puts "Id: " + node.attribute("id").to_s + "Ar: " + node.attribute("ar").to_s + " Idotartam" + node.attribute("idotartam").to_s
					# f = Fakultativ.new(:id => node.attribute("id").to_s, :length => node.attribute("idotartam").to_s, :price => node.attribute("ar").to_s)
					puts node.attribute("id").to_s
					f = Fakultativ.find_or_create_by_id(node.attribute("id").to_s)
					f.length = node.attribute("idotartam").to_s
					f.price = node.attribute("ar").to_s
					until (node.name.to_s == "fakultativ" && node.node_type.to_s == '15')
						node.read	
						if node.name.to_s == "cim" && node.node_type.to_s == '1'
							#puts "Cim: " + node.inner_xml.to_s
							f.title = node.inner_xml.to_s[9..-4]
						end
						if node.name.to_s == "leiras" && node.node_type.to_s == '1'
							#puts "Leiras: " + node.inner_xml.to_s
							f.description = node.inner_xml.to_s[9..-4]
						end
						if node.name.to_s == "fakultativ" && node.node_type.to_s == '15'
							f.save
							t.fakultativs << f
						end
					end
				end
			
				#Fakultativ vege
				#Idopontok
				if node.name.to_s == "prices"
					price_count = node.attribute("count").to_i
					c = 0

					until (c == price_count || (node.name.to_s == "prices" && node.node_type.to_s == '15'))
						node.read
						if node.name.to_s == "idopont" && node.node_type.to_s == '1'
							c = c + 1
							#puts "Price count: " + price_count.to_s
							#puts "C: " + c.to_s

							#puts "Id: " + node.attribute("id").to_s
							#puts "From: " + node.attribute("fromdate").to_s
							#puts "Todate: " + node.attribute("todate").to_s
							#puts "lejar_ar: " + node.attribute("lejar_ar").to_s
							#puts "szobakalk: " + node.attribute("szobakalk").to_s
							#puts "ej: " + node.attribute("ej").to_s
							#puts "nap: " + node.attribute("nap").to_s
							#puts "price: " + node.attribute("price").to_s
							#puts "akcios: " + node.attribute("akcios").to_s
							#puts "ellatas: " + node.attribute("ellatas").to_s
							#puts "agyszam: " + node.attribute("agyszam").to_s
							#puts "foglalasi_dij: " + node.attribute("foglalasi_dij").to_s
							#puts "transzfer_dij: " + node.attribute("transzfer_dij").to_s
							#puts "szervidij: " + node.attribute("szervidij").to_s
							#puts "vizum_dij: " + node.attribute("vizum_dij").to_s
							#puts "repteri_illetek: " + node.attribute("repteri_illetek").to_s
							#puts "storno_biztositas: " + node.attribute("storno_biztositas").to_s
							#puts "bpp: " + node.attribute("bpp").to_s
							#puts "kerozin_potdij: " + node.attribute("kerozin_potdij").to_s
							#puts "egyeni_idopont: " + node.attribute("egyeni_idopont").to_s

							tt = TravelTime.new(
							:id => node.attribute("id").to_s,
							:from_date => node.attribute("fromdate").to_s,
							:to_date => node.attribute("todate").to_s,
							:price_expire => node.attribute("lejar_ar").to_s,
							:price_measure => node.attribute("szobakalk").to_s,
							:night => node.attribute("ej").to_s,
							:day => node.attribute("nap").to_s,
							:price => node.attribute("price").to_s,
							:discount => node.attribute("akcios").to_s,
							:service => node.attribute("ellatas").to_s,
							:bed => node.attribute("agyszam").to_s,
							:reservation_fee => node.attribute("foglalasi_dij").to_s,
							:transfer_fee => node.attribute("transzfer_dij").to_s,
							:service_fee => node.attribute("szervidij").to_s,
							:visa_fee => node.attribute("vizum_dij").to_s,
							:airport_tax => node.attribute("repteri_illetek").to_s,
							:storno_insurance => node.attribute("storno_biztositas").to_s,
							:bpp => node.attribute("bpp").to_s,
							:kerosene_charge => node.attribute("kerozin_potdij").to_s,
							:individual => node.attribute("egyeni_idopont").to_s
							)
						end

						if node.name.to_s == "idopont_tipus" && node.node_type.to_s == '1'
							#puts "idopont_tipus: " + node.inner_xml.to_s
							tt.travel_time_type_name = node.inner_xml.to_s[9..-4]
						end
						if node.name.to_s == "idopont_tipuskod" && node.node_type.to_s == '1'
							#puts "idopont_tipuskod: " + node.inner_xml.to_s
							tt.travel_time_type_code = node.inner_xml.to_s[9..-4]
						end
						if node.name.to_s == "departure_city" && node.node_type.to_s == '1'
							#puts "departure_city: " + node.inner_xml.to_s
							tt.departure_city_id = node.inner_xml.to_s[9..-4]
						end
						if node.name.to_s == "megjegyzes" && node.node_type.to_s == '1'
							#puts "megjegyzes: " + node.inner_xml.to_s
							tt.note = node.inner_xml.to_s[9..-4]
						end
						#idopont opcionalis
						if node.name.to_s == "opcio" && node.node_type.to_s == '1'
							#puts "ar: " + node.attribute("ar").to_s
							#puts "ar_tipus: " + node.attribute("ar_tipus").to_s
							#puts "opcios: " + node.attribute("opcios").to_s
							#puts "kedvezmeny: " + node.attribute("kedvezmeny").to_s
							#puts "eletkortol: " + node.attribute("eletkortol").to_s
							#puts "eletkorig: " + node.attribute("eletkorig").to_s

							of = OptionalFee.new(
								:price => node.attribute("ar").to_s,
								:price_type => node.attribute("ar_tipus").to_s,
								:discount => node.attribute("kedvezmeny").to_s,
								:optional => node.attribute("opcios").to_s,
								:age_from => node.attribute("eletkortol").to_s,
								:age_to => node.attribute("eletkorig").to_s
							)
						end
						if node.name.to_s == "name" && node.node_type.to_s == '1'
							#puts "name: " + node.inner_xml.to_s
							of.name = node.inner_xml.to_s[9..-4]
							of.save
							tt.optional_fees << of
						end
						#idopont opcionalis vege
						if node.name.to_s == "inprice" && node.node_type.to_s == '1'
							#puts "Inprice: " + node.inner_xml.to_s
							tt.inprices << Inprice.find(node.inner_xml.to_s)
						end
						if node.name.to_s == "outprice" && node.node_type.to_s == '1'
							#puts "Outprice: " + node.inner_xml.to_s
							tt.outprices << Outprice.find(node.inner_xml.to_s)
						end

						if node.name.to_s == "elofoglalas" && node.node_type.to_s == '1'
							#puts "datum_kezd: " + node.attribute("datum_kezd").to_s
							#puts "datum_vege: " + node.attribute("datum_vege").to_s
							#puts "tipus: " + node.attribute("tipus").to_s

							pb = PreBooking.new(
									:start_date => node.attribute("datum_kezd").to_s,
									:end_date => node.attribute("datum_vege").to_s,
									:amount_type => node.attribute("tipus").to_s
								)
						end
						if node.name.to_s == "osszeg" && node.node_type.to_s == '1'
							#puts "osszeg: " + node.inner_xml.to_s
							pb.amount = node.inner_xml.to_s
						end
						if node.name.to_s == "szoveg" && node.node_type.to_s == '1'
							#puts "szoveg: " + node.inner_xml.to_s
							pb.description = node.inner_xml.to_s
							pb.save
							tt.pre_bookings << pb
						end

						if node.name.to_s == "gyerek_ar" && node.node_type.to_s == '1'
							#puts "index: " + node.attribute("index").to_s
							#puts "kortol: " + node.attribute("kortol").to_s
							#puts "korig: " + node.attribute("korig").to_s
							#puts "agytipus: " + node.attribute("agytipus").to_s
							#puts "ar_tipus: " + node.attribute("ar_tipus").to_s
							#puts "ar: " + node.attribute("ar").to_s

							tt.child_prices << ChildPrice.new(
								:age_from => node.attribute("kortol").to_s,
								:age_to => node.attribute("korig").to_s,
								:bed_type => node.attribute("agytipus").to_s,
								:price_type => node.attribute("ar_tipus").to_s,
								:price => node.attribute("ar").to_s
							)
						end

						if node.name.to_s == "idopont" && node.node_type.to_s == '15'
							begin tt.save!
								t.travel_times << tt
								puts "TravelTime saved successfully"
							rescue Exception => e
		  					puts "Error during save process: #{e.class}"
							end
							puts "Időpont vége"
						end
					end
				end
				#Idopontok vege
				if node.name.to_s == 'traveloffer' && node.node_type.to_s == '15'
					counter = counter + 1
					new_offer = 0
					begin t.save!
						changed_counter = changed_counter + 1
						puts "Offer saved successfully"
					rescue Exception => e
		  			puts "Error during save process: #{e.class}"
					end
				end
			end
			puts "Changed offer: " + changed_counter.to_s
			puts "Current offer: " + counter.to_s
			puts "Offers remaining: " + (total_count.to_i - counter).to_s
			puts "New offer: " + new_offer.to_s
		end

		puts "Offers save: " + counter.to_s
		puts ((Time.now - time) / 60).to_s

	end

end
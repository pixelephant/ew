# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120618095157) do

  create_table "boards", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "child_prices", :force => true do |t|
    t.integer  "age_from"
    t.integer  "age_to"
    t.string   "bed_type"
    t.string   "price_type"
    t.integer  "price"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "travel_time_id"
  end

  create_table "cities", :force => true do |t|
    t.integer  "country_id"
    t.integer  "region_id"
    t.string   "name"
    t.string   "lat"
    t.string   "long"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "continent"
    t.integer  "position"
  end

  create_table "descriptions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "travel_offer_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "destinations", :force => true do |t|
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "city_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "destinations_travel_offers", :force => true do |t|
    t.integer  "destination_id"
    t.integer  "travel_offer_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "destinations_travel_offers", ["destination_id", "travel_offer_id"], :name => "foreign_keys"

  create_table "fakultativs", :force => true do |t|
    t.integer  "price"
    t.string   "length"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "travel_offer_id"
  end

  create_table "goods", :force => true do |t|
    t.integer  "country_id"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "holidays", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "travel_offer_id"
    t.string   "file_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "special"
    t.string   "own_image_file"
  end

  create_table "in_out_prices", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inprices", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inprices_travel_offers", :force => true do |t|
    t.integer  "inprice_id"
    t.integer  "travel_offer_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "inprices_travel_times", :force => true do |t|
    t.integer  "inprice_id"
    t.integer  "travel_time_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "optional_fees", :force => true do |t|
    t.string   "name"
    t.integer  "travel_time_id"
    t.integer  "price"
    t.string   "price_type"
    t.boolean  "optional"
    t.boolean  "discount"
    t.integer  "category_id"
    t.integer  "age_from"
    t.integer  "age_to"
    t.date     "valid_from"
    t.date     "valid_to"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "travel_time_id"
    t.integer  "adult"
    t.integer  "children"
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "note"
    t.string   "partner_name"
    t.text     "travel_text"
  end

  create_table "outprices", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "outprices_travel_offers", :force => true do |t|
    t.integer  "outprice_id"
    t.integer  "travel_offer_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "outprices_travel_times", :force => true do |t|
    t.integer  "outprice_id"
    t.integer  "travel_time_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "partners", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "contact"
    t.integer  "offers"
    t.text     "info"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pre_bookings", :force => true do |t|
    t.integer  "travel_time_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "amount_type"
    t.integer  "amount"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "program_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "program_types_travel_offers", :force => true do |t|
    t.integer  "program_type_id"
    t.integer  "travel_offer_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "program_types_travel_offers", ["program_type_id", "travel_offer_id"], :name => "foreign_keys"

  create_table "regions", :force => true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skiregions", :force => true do |t|
    t.integer  "region_id"
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "traffics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "travel_attributes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "travel_attributes_travel_offers", :force => true do |t|
    t.integer  "travel_attribute_id"
    t.integer  "travel_offer_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "travel_offers", :force => true do |t|
    t.string   "md5"
    t.integer  "partner_id"
    t.string   "travel_name"
    t.string   "szallas_name"
    t.integer  "category_standard"
    t.string   "category_aleph"
    t.integer  "board_id"
    t.integer  "traffic_id"
    t.string   "gallery_url",       :default => "http://localhost:3000/uploads/", :null => false
    t.text     "gmap"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.integer  "skiregion_id"
    t.integer  "click"
    t.string   "slug"
    t.boolean  "special"
  end

  add_index "travel_offers", ["slug"], :name => "index_travel_offers_on_slug", :unique => true

  create_table "travel_offers_traveldays", :force => true do |t|
    t.integer  "travelday_id"
    t.integer  "travel_offer_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "travel_times", :force => true do |t|
    t.integer  "travel_offer_id"
    t.date     "from_date",             :default => '2012-01-01', :null => false
    t.date     "to_date",               :default => '2012-01-01', :null => false
    t.datetime "price_expire"
    t.string   "price_measure"
    t.integer  "night"
    t.integer  "day"
    t.integer  "price"
    t.boolean  "discount"
    t.string   "service"
    t.integer  "bed"
    t.integer  "reservation_fee"
    t.integer  "transfer_fee"
    t.integer  "service_fee"
    t.integer  "visa_fee"
    t.integer  "airport_tax"
    t.string   "storno_insurance"
    t.string   "bpp"
    t.integer  "kerosene_charge"
    t.boolean  "individual"
    t.string   "travel_time_type_name"
    t.string   "travel_time_type_code"
    t.integer  "departure_city_id"
    t.text     "note"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.boolean  "sale"
    t.string   "slug"
  end

  add_index "travel_times", ["from_date"], :name => "from_date"
  add_index "travel_times", ["slug"], :name => "index_travel_times_on_slug", :unique => true
  add_index "travel_times", ["to_date"], :name => "to_date"
  add_index "travel_times", ["travel_offer_id", "from_date", "to_date"], :name => "dates"
  add_index "travel_times", ["travel_offer_id"], :name => "travel_offer_id"

  create_table "traveldays", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

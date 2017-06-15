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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170615073314) do

  create_table "athletics_supporters_package_price_list_all", primary_key: "serial_no", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "athletics_supporter_packages", limit: 10, null: false
    t.string  "hotel_name",                   limit: 51, null: false
    t.integer "pax",                                     null: false
    t.string  "nights",                       limit: 9,  null: false
    t.date    "check_in",                                null: false
    t.date    "check_out",                               null: false
    t.string  "price_aud",                    limit: 12, null: false
    t.string  "price_gbp",                    limit: 8,  null: false
  end

  create_table "countries", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",              limit: 50, null: false
    t.string   "pics_file_name"
    t.string   "pics_content_type"
    t.integer  "pics_file_size"
    t.datetime "pics_updated_at"
  end

  create_table "db_event_data", primary_key: "ev_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "ev_function_group",   limit: 125, null: false
    t.string  "ev_name_without_cat", limit: 125, null: false
    t.string  "ev_name_with_cat",    limit: 125, null: false
    t.date    "ev_date",                         null: false
    t.string  "ev_start_time",       limit: 125, null: false
    t.string  "ev_end_time",         limit: 125, null: false
    t.string  "ev_overview",                     null: false
    t.string  "ev_item_with_cat",    limit: 125, null: false
    t.string  "ev_item_without_cat", limit: 125, null: false
    t.string  "ev_category",         limit: 125, null: false
    t.string  "ev_ticket",           limit: 125, null: false
    t.string  "ev_category_ticket",  limit: 125, null: false
    t.string  "ev_session_type",     limit: 125, null: false
    t.string  "ev_prime_event",      limit: 125, null: false
    t.string  "ev_gender",           limit: 25,  null: false
    t.string  "ev_details",                      null: false
    t.string  "ev_venue",                        null: false
    t.integer "ev_sell_price",                   null: false
    t.boolean "ev_status",                       null: false
  end

  create_table "event_shopping_carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",               null: false
    t.string   "event_id"
    t.string   "event_cat"
    t.datetime "event_date"
    t.float    "rate",       limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "event_name"
  end

  create_table "event_ticket_request", primary_key: "req_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "req_event_id"
    t.string   "req_event_name",       limit: 200
    t.date     "req_event_date"
    t.string   "req_event_category",   limit: 150
    t.string   "req_ticket_num",       limit: 10
    t.string   "req_event_user_name",  limit: 125
    t.string   "req_event_user_email", limit: 125
    t.string   "req_event_user_phone", limit: 125
    t.datetime "req_created",                      default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean  "req_status",                       default: false,                      null: false
  end

  create_table "event_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",    null: false
    t.string   "event_id"
    t.string   "event_cat"
    t.datetime "event_date"
    t.integer  "rate"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "event_name"
    t.string   "pay_id"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "event_code"
    t.string   "session_type"
    t.string   "prime_event"
    t.string   "gender"
    t.text     "detail",       limit: 65535
    t.string   "venue"
  end

  create_table "exclisive_second_old", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "country",    limit: 50, null: false
    t.string   "thumb",      limit: 50, null: false
    t.string   "is_active",  limit: 50, null: false
    t.datetime "created_at",            null: false
    t.integer  "ord_by"
  end

  create_table "exclusive_old", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "country",   limit: 50, null: false
    t.string "thumb",     limit: 50, null: false
    t.string "is_active", limit: 50, null: false
  end

  create_table "exclusive_seconds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "country",           null: false
    t.boolean  "is_active"
    t.string   "pics_file_name"
    t.string   "pics_content_type"
    t.integer  "pics_file_size"
    t.datetime "pics_updated_at"
    t.integer  "order_by"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "exclusives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",              null: false
    t.boolean  "is_active"
    t.string   "pics_file_name"
    t.string   "pics_content_type"
    t.integer  "pics_file_size"
    t.datetime "pics_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "features", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",              null: false
    t.string   "pics_file_name"
    t.string   "pics_content_type"
    t.integer  "pics_file_size"
    t.datetime "pics_updated_at"
    t.string   "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "groups", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",        limit: 20,  null: false
    t.string "description", limit: 100, null: false
  end

  create_table "hotel_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "hotel_id",          null: false
    t.string   "pics_file_name"
    t.string   "pics_content_type"
    t.integer  "pics_file_size"
    t.datetime "pics_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "hotel_shopping_carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",        null: false
    t.integer  "hotel_id"
    t.datetime "from_date"
    t.datetime "to_date"
    t.integer  "rate"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "room_unique_id"
    t.string   "room_type"
  end

  create_table "hotel_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                   null: false
    t.integer  "hotel_id"
    t.datetime "from_date"
    t.datetime "to_date"
    t.float    "rate",           limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "room_unique_id"
    t.string   "room_type"
    t.string   "status"
    t.string   "pay_id"
  end

  create_table "hotels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                            null: false
    t.string   "address",                         null: false
    t.integer  "star_rating"
    t.text     "description",       limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "pics_file_name"
    t.string   "pics_content_type"
    t.integer  "pics_file_size"
    t.datetime "pics_updated_at"
    t.string   "video_link"
    t.string   "unique_id"
  end

  create_table "hotels_amenities", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "for_hotel_id",                     null: false
    t.string  "for_hotel_name",       limit: 200
    t.integer "PrivateBathroom",                  null: false
    t.integer "FlatScreenTV",                     null: false
    t.integer "AirConditioning",                  null: false
    t.integer "SafetyDepositBox",                 null: false
    t.integer "Iron",                             null: false
    t.integer "TrouserPress",                     null: false
    t.integer "Desk",                             null: false
    t.integer "IroningFascilities",               null: false
    t.integer "SeatingArea",                      null: false
    t.integer "Heating",                          null: false
    t.integer "Hardwood",                         null: false
    t.integer "Wardrobe",                         null: false
    t.integer "Shower",                           null: false
    t.integer "Bath",                             null: false
    t.integer "Hairdryer",                        null: false
    t.integer "Bathrobe",                         null: false
    t.integer "Slippers",                         null: false
    t.integer "Pay-Per-ViewChannels",             null: false
    t.integer "Telephone",                        null: false
    t.integer "Radio",                            null: false
    t.integer "DVDPlayer",                        null: false
    t.integer "SatelliteChannels",                null: false
    t.integer "CableChannels",                    null: false
    t.integer "balcony"
    t.integer "sofa"
    t.integer "free_toiletries"
    t.integer "refrigerator"
    t.integer "microwave"
    t.integer "dishwasher"
    t.integer "kitchen"
    t.integer "DiningArea"
    t.integer "AlarmCLock"
    t.integer "FreeWifi"
    t.integer "Patio"
    t.integer "seaview"
    t.integer "TumbleDryer"
    t.integer "Tea_CoffeeMaker"
    t.integer "Oven"
    t.integer "Toaster"
    t.integer "Stovetop"
    t.integer "Towels"
    t.integer "Linen"
    t.integer "ElectricKettle"
    t.integer "MeetingRoom"
    t.integer "BBQAreaPoolSide"
    t.integer "OutdoorPool"
    t.integer "Toilet"
    t.integer "Minibar"
    t.integer "Fan"
    t.integer "WashingMachine"
    t.integer "DiningTable"
    t.integer "Carpeted"
    t.integer "interconnectedRooms"
    t.integer "wakeupService"
    t.integer "OutdoorFurniture"
    t.integer "outdoorDiningArea"
    t.integer "GardenView"
    t.integer "poolView"
    t.integer "UpperFloorsStairs"
  end

  create_table "hotels_images", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "for_hotel_id",               null: false
    t.string  "for_hotel_name", limit: 100, null: false
    t.string  "image1",         limit: 100, null: false
    t.string  "image2",         limit: 100, null: false
    t.string  "image3",         limit: 100, null: false
    t.string  "image4",         limit: 100, null: false
    t.string  "image5",         limit: 100, null: false
    t.string  "image6",         limit: 100, null: false
    t.string  "image7",         limit: 100, null: false
    t.string  "image8",         limit: 100, null: false
  end

  create_table "kngd_hotels", primary_key: "hotel_id", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "hotel_name",         limit: 100,               null: false
    t.text    "hotel_address",      limit: 65535
    t.string  "hotel_desc_heading", limit: 100
    t.text    "hotel_desc",         limit: 65535
    t.string  "room_type",          limit: 100
    t.string  "room_size",          limit: 100
    t.string  "aspect",             limit: 100
    t.string  "breakfast",          limit: 100
    t.integer "hotel_rating"
    t.string  "persons_allowed",    limit: 100
    t.string  "nights",             limit: 100
    t.string  "daily_Rate",         limit: 100
    t.string  "total_rate",         limit: 100
    t.integer "hotel_status"
    t.integer "is_featured",                      default: 0, null: false
  end

  create_table "kngdm_hotels", primary_key: "item_code", id: :string, limit: 55, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.integer "hotel_id",                         null: false
    t.string  "hotel_name",         limit: 23,    null: false
    t.string  "hotel_address",      limit: 56,    null: false
    t.string  "hotel_desc_heading", limit: 100,   null: false
    t.text    "hotel_desc",         limit: 65535, null: false
    t.string  "room_type",          limit: 100,   null: false
    t.string  "room_size",          limit: 100,   null: false
    t.string  "aspect",             limit: 100,   null: false
    t.integer "hotel_rating",                     null: false
    t.date    "chk_in",                           null: false
    t.date    "chk_out",                          null: false
    t.integer "stock",                            null: false
    t.integer "persons_allowed",                  null: false
    t.integer "nights",                           null: false
    t.string  "daily_Rate",         limit: 11,    null: false
    t.string  "total_rate",         limit: 12,    null: false
    t.integer "hotel_status",                     null: false
    t.integer " \tis_featured",                   null: false
  end

  create_table "kngdsg_hotels", primary_key: "item_code", id: :string, limit: 55, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "hotel_id",                         null: false
    t.string  "hotel_name",         limit: 55,    null: false
    t.string  "hotel_address",      limit: 66,    null: false
    t.string  "room_type",          limit: 55,    null: false
    t.string  "chk_in",             limit: 55,    null: false
    t.string  "chk_out",            limit: 55,    null: false
    t.integer "stock",                            null: false
    t.integer "persons_allowed",                  null: false
    t.integer "nights",                           null: false
    t.integer "daily_rate",                       null: false
    t.string  "total_rate",         limit: 55,    null: false
    t.integer "hotel_status"
    t.text    "hotel_desc",         limit: 65535
    t.text    "hotel_desc_heading", limit: 65535
  end

  create_table "login_attempts", id: :integer, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "ip_address", limit: 15,  null: false
    t.string  "login",      limit: 100, null: false
    t.integer "time",                                unsigned: true
  end

  create_table "mytable", primary_key: "hotel_id", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string  "hotel_name",         limit: 25, null: false
    t.string  "hotel_address",      limit: 30
    t.string  "hotel_desc_heading", limit: 30
    t.string  "hotel_desc",         limit: 30
    t.string  "room_type",          limit: 29, null: false
    t.string  "room_size",          limit: 30
    t.string  "aspect",             limit: 30
    t.string  "beakfast",           limit: 30
    t.integer "persons_allowed",               null: false
    t.integer "nights",                        null: false
    t.string  "daily_Rate",         limit: 11, null: false
    t.string  "total_rate",         limit: 12, null: false
    t.integer "hotel_Rating"
    t.binary  "hotel_status",       limit: 1
  end

  create_table "newsletter", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",      limit: 50, null: false
    t.datetime "created_at",            null: false
  end

  create_table "own_package_price_list", primary_key: "ID", id: :integer, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string  "bundle",                 limit: 20,  null: false
    t.integer "nights",                             null: false
    t.date    "check_in",                           null: false, comment: "YYYY-MM-DD"
    t.date    "check_out",                          null: false, comment: "YYYY-MM-DD"
    t.string  "hotel",                  limit: 200, null: false
    t.string  "room_type",              limit: 50,  null: false
    t.integer "event_tickets_included",             null: false
    t.integer "aud_2px_per_person",                 null: false
    t.integer "aud_1px_price_for_1",                null: false
    t.integer "gbp_2px_per_person",                 null: false
    t.integer "gbp_1px_price_for_1",                null: false
  end

  create_table "packages_opening_dual_price_list", primary_key: "serial_no", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "item_number",          limit: 21, null: false
    t.string  "description",          limit: 26, null: false
    t.string  "hotel",                limit: 51, null: false
    t.integer "people",                          null: false
    t.string  "nightsdays",           limit: 17, null: false
    t.date    "check_in",                        null: false
    t.date    "check_out",                       null: false
    t.string  "aud_price_per_person", limit: 10, null: false
    t.string  "aud_total_price",      limit: 11, null: false
    t.string  "gbp_price_per_person", limit: 10, null: false
    t.string  "gbp_total_price",      limit: 10, null: false
  end

  create_table "packages_rugby_dual_price_list", primary_key: "serial_no", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "category",             limit: 10, null: false
    t.string  "item_number",          limit: 21, null: false
    t.string  "descrtption",          limit: 36, null: false
    t.string  "hotel",                limit: 51, null: false
    t.integer "people",                          null: false
    t.string  "nightsdays",           limit: 17, null: false
    t.date    "check_n",                         null: false
    t.date    "check_out",                       null: false
    t.string  "aud_price_per_person", limit: 10, null: false
    t.string  "aud_total_price",      limit: 10, null: false
    t.string  "gbp_price_per_person", limit: 10, null: false
    t.string  "gbp_total_price",      limit: 10, null: false
  end

  create_table "packages_swimming_dual_price", primary_key: "serial_no", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "item_number",          limit: 21, null: false
    t.string  "descrption",           limit: 27, null: false
    t.string  "hotel",                limit: 51, null: false
    t.integer "people",                          null: false
    t.string  "nightsdays",           limit: 17, null: false
    t.date    "check_in",                        null: false
    t.date    "check_out",                       null: false
    t.string  "aud_price_per_person", limit: 10, null: false
    t.string  "aud_total",            limit: 11, null: false
    t.string  "gbp_price_per_person", limit: 10, null: false
    t.string  "gbp_total",            limit: 11, null: false
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                        null: false
    t.text     "description",   limit: 65535
    t.integer  "hotel_id"
    t.text     "details",       limit: 65535
    t.string   "rooms_type"
    t.integer  "size"
    t.string   "layout"
    t.boolean  "breakfast"
    t.integer  "max_occupancy"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "unique_id"
  end

  create_table "rooms_features", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "room_id"
    t.integer  "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text "header_logo",        limit: 65535, null: false
    t.text "banner_img",         limit: 65535, null: false
    t.text "banner_heading",     limit: 65535, null: false
    t.text "banner_sub_text",    limit: 65535, null: false
    t.text "banner_btn_text",    limit: 65535, null: false
    t.text "banner_btn_link",    limit: 65535, null: false
    t.text "footer_logo",        limit: 65535, null: false
    t.text "bottom_footer_logo", limit: 65535, null: false
    t.text "footer_link",        limit: 65535, null: false
    t.text "footer_sub_link",    limit: 65535, null: false
    t.text "contact_us",         limit: 65535, null: false
    t.text "facebook",           limit: 65535, null: false
    t.text "instagram",          limit: 65535, null: false
    t.text "twitter",            limit: 65535, null: false
  end

  create_table "staticpages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "password"
    t.string  "email",           limit: 100, null: false
    t.string  "activation_code", limit: 40
    t.integer "created_on",                  null: false, unsigned: true
    t.boolean "active",                                   unsigned: true
    t.string  "first_name",      limit: 50
    t.string  "last_name",       limit: 50
    t.string  "phone",           limit: 20
    t.string  "password_digest"
  end

  create_table "users_groups", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id",                 null: false, unsigned: true
    t.integer "user_id",            null: false, unsigned: true
    t.integer "group_id", limit: 3, null: false, unsigned: true
  end

end

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

ActiveRecord::Schema.define(version: 20170622064602) do

  create_table "carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "item"
    t.integer  "item_id"
    t.string   "item_uid"
    t.string   "item_cat_code"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
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

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "my_orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "item"
    t.integer  "item_id"
    t.string   "item_uid"
    t.string   "item_cat_code"
    t.integer  "quantity"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "my_payment_id"
    t.float    "rate",          limit: 24
  end

  create_table "my_payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.float    "total",      limit: 24
    t.date     "date"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "order_id"
    t.string   "payment_id"
    t.float    "freight",    limit: 24
    t.float    "cc_amount",  limit: 24
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "hotel_id"
    t.string  "room_type"
    t.string  "room_code"
    t.date    "check_in_date"
    t.date    "check_out_date"
    t.integer "max_person"
    t.integer "no_of_night"
    t.float   "rate",           limit: 24
  end

  create_table "rooms_features", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "room_id"
    t.integer  "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms_old", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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

  create_table "users", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "password"
    t.string  "email",           limit: 100,   null: false
    t.string  "activation_code", limit: 40
    t.integer "created_on",                    null: false, unsigned: true
    t.boolean "active",                                     unsigned: true
    t.string  "first_name",      limit: 50
    t.string  "last_name",       limit: 50
    t.string  "phone",           limit: 20
    t.string  "password_digest"
    t.string  "middle_name"
    t.text    "address",         limit: 65535
    t.text    "city",            limit: 65535
    t.string  "state"
    t.integer "post_code"
    t.string  "country"
  end

end

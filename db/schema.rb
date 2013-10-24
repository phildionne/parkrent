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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131024015806) do

  create_table "orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rent_id"
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "deleted_at"
  end

  add_index "orders", ["rent_id"], name: "index_orders_on_rent_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"
  add_index "orders", ["vehicle_id"], name: "index_orders_on_vehicle_id"

  create_table "parkings", force: true do |t|
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "itinerary"
    t.boolean  "published",  default: false
  end

  add_index "parkings", ["user_id"], name: "index_parkings_on_user_id"

  create_table "payments", force: true do |t|
    t.decimal  "amount"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.datetime "deleted_at"
    t.string   "stripe_charge_id"
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id"

  create_table "rents", force: true do |t|
    t.datetime "beginning"
    t.datetime "termination"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parking_id"
    t.integer  "price_cents",    default: 0,     null: false
    t.string   "price_currency", default: "CAD", null: false
    t.text     "schedule"
  end

  add_index "rents", ["parking_id"], name: "index_rents_on_parking_id"

  create_table "stripe_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "stripe_user_id"
    t.string   "publishable_key"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "deleted_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vehicles", force: true do |t|
    t.string  "license_plate"
    t.integer "user_id"
    t.string  "model"
    t.date    "year"
  end

  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id"

end

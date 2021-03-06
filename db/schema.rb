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

ActiveRecord::Schema.define(:version => 20110519113034) do

  create_table "restaurants", :force => true do |t|
    t.string  "name"
    t.string  "photo"
    t.string  "logo"
    t.string  "cuisine"
    t.date    "offer_end_date"
    t.string  "offer_valid_days"
    t.string  "offer_valid_times"
    t.string  "address"
    t.string  "phone"
    t.string  "website"
    t.string  "address_line_2"
    t.integer "offer"
    t.boolean "visible",           :default => true
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zip_code"
    t.string   "remember_token"
  end

end

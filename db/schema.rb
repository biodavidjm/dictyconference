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

ActiveRecord::Schema.define(:version => 20120327220334) do

  create_table "abstracts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "presenter"
    t.text     "abstract"
    t.boolean  "agreement"
    t.text     "note_to_organizers"
    t.string   "abstract_type"
    t.string   "authors"
    t.text     "address"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                                   :null => false
    t.boolean  "is_admin",             :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                       :null => false
    t.integer  "login_count",          :default => 0,     :null => false
    t.integer  "failed_login_count",   :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "city"
    t.string   "zipcode"
    t.string   "country"
    t.string   "passport"
    t.string   "phone"
    t.string   "institute"
    t.string   "address"
    t.boolean  "is_registered"
    t.string   "accommodation_type"
    t.boolean  "has_guest"
    t.string   "roomie_first_name"
    t.string   "roomie_last_name"
    t.boolean  "guest_trip"
    t.boolean  "guest_supplement_HB"
    t.boolean  "guest_supplement_HBD"
    t.boolean  "extra_accommodation"
    t.date     "check_in"
    t.date     "check_out"
    t.text     "comment"
    t.string   "billing_id"
    t.string   "payment_due"
  end

end

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

ActiveRecord::Schema.define(:version => 20130707203700) do

  create_table "images", :force => true do |t|
    t.string   "url"
    t.integer  "place_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "interests", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "interests_trips", :force => true do |t|
    t.integer "interest_id"
    t.integer "trip_id"
  end

  create_table "interests_users", :force => true do |t|
    t.integer "interest_id"
    t.integer "user_id"
  end

  create_table "invitations", :force => true do |t|
    t.string   "hash_id"
    t.integer  "trip_id"
    t.string   "mail_to"
    t.string   "mail_from"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image"
    t.text     "description"
  end

  create_table "places_trips", :id => false, :force => true do |t|
    t.integer "place_id"
    t.integer "trip_id"
  end

  create_table "trips", :force => true do |t|
    t.string   "name"
    t.string   "cover_image_url"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "description"
  end

  create_table "trips_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "trip_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "email"
    t.string   "name"
    t.string   "lastname"
    t.integer  "deleted"
    t.boolean  "admin"
    t.string   "hash_password"
    t.string   "token"
    t.string   "salt"
    t.string   "profile"
    t.string   "profile_picture_url"
    t.string   "image_url"
  end

end

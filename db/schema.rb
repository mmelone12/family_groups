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

ActiveRecord::Schema.define(version: 20131004162033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "title"
    t.string   "image_path"
    t.string   "desc"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "where"
    t.string   "address"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "link"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "article_link"
    t.string   "website_link"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "uploader_image"
    t.integer  "user_id"
  end

  create_table "activity_relationships", force: true do |t|
    t.integer  "activity_follower_id"
    t.integer  "activity_followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_relationships", force: true do |t|
    t.integer  "group_follower_id"
    t.integer  "group_followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "image_path"
    t.string   "desc"
    t.string   "link"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "address"
    t.boolean  "original_record", default: false
    t.string   "uploader_image"
  end

  create_table "interests", force: true do |t|
    t.string   "name"
    t.string   "image_path"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "desc"
    t.string   "image_path"
    t.string   "uploader_image"
    t.string   "city"
    t.string   "address"
    t.string   "website"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
  end

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "state"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end

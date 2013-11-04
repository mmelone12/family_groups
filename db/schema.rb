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

ActiveRecord::Schema.define(version: 20131103225531) do

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
    t.float    "latitude"
    t.float    "longitude"
    t.string   "recurring"
    t.string   "when"
  end

  create_table "activity_relationships", force: true do |t|
    t.integer  "activity_follower_id"
    t.integer  "activity_followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatars", force: true do |t|
    t.string   "image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
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
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "message_copies", force: true do |t|
    t.integer  "recipient_id"
    t.integer  "message_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "read_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "author_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "read_at"
  end

  create_table "place_relationships", force: true do |t|
    t.integer  "place_follower_id"
    t.integer  "place_followed_id"
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
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "plans", force: true do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "subscriptions", force: true do |t|
    t.integer  "plan_id"
    t.integer  "user_id"
    t.string   "stripe_customer_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

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
    t.string   "gender"
    t.string   "single_parent"
    t.string   "new_parent"
    t.string   "special_needs"
    t.string   "children_under_5"
    t.string   "children_5_10"
    t.string   "tweens"
    t.string   "teens"
    t.string   "non_parent"
    t.string   "uploader_image"
    t.string   "desc"
    t.string   "image_path"
    t.string   "last_name"
    t.boolean  "premium",          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end

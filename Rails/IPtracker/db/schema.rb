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

ActiveRecord::Schema.define(version: 20130824224527) do

  create_table "cdscells", force: true do |t|
    t.string   "name"
    t.integer  "cdslib_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "xsize"
    t.integer  "ysize"
    t.string   "layimg_file_name"
    t.string   "layimg_content_type"
    t.integer  "layimg_file_size"
    t.datetime "layimg_updated_at"
    t.string   "string_file_name"
    t.string   "string_content_type"
    t.integer  "string_file_size"
    t.datetime "string_updated_at"
    t.integer  "area"
  end

  add_index "cdscells", ["cdslib_id"], name: "index_cdscells_on_cdslib_id"

  create_table "cdslibs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "celltrackers", force: true do |t|
    t.integer  "tracker_id"
    t.integer  "tracked_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "celltrackers", ["tracked_id"], name: "index_celltrackers_on_tracked_id"
  add_index "celltrackers", ["tracker_id", "tracked_id"], name: "index_celltrackers_on_tracker_id_and_tracked_id", unique: true
  add_index "celltrackers", ["tracker_id"], name: "index_celltrackers_on_tracker_id"

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "silicons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "silicontrackers", force: true do |t|
    t.integer  "silicon_id"
    t.integer  "cdscell_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "silicontrackers", ["cdscell_id"], name: "index_silicontrackers_on_cdscell_id"
  add_index "silicontrackers", ["silicon_id", "cdscell_id"], name: "index_silicontrackers_on_silicon_id_and_cdscell_id", unique: true
  add_index "silicontrackers", ["silicon_id"], name: "index_silicontrackers_on_silicon_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.string   "title"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end

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

ActiveRecord::Schema.define(version: 20160308020754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "resorts", force: :cascade do |t|
    t.string   "name"
    t.string   "official_name"
    t.string   "state"
    t.text     "description"
    t.decimal  "latitude",      precision: 9, scale: 6
    t.decimal  "longitude",     precision: 9, scale: 6
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "zip_code"
  end

  add_index "resorts", ["user_id"], name: "index_resorts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "provider"
    t.string   "email"
    t.string   "token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "phone_number"
  end

  add_foreign_key "resorts", "users"
end

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

ActiveRecord::Schema.define(version: 20150531134724) do

  create_table "analysis", force: :cascade do |t|
    t.string "observation", limit: 255
    t.string "result",      limit: 255
  end

  create_table "doctors", force: :cascade do |t|
    t.string "pacient_policy", limit: 255
    t.string "pacient_name",   limit: 255
  end

  create_table "doctors_pacients", force: :cascade do |t|
    t.integer "doctor_id",  limit: 4
    t.integer "pacient_id", limit: 4
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "groups_url_types", force: :cascade do |t|
    t.integer "url_type_id", limit: 4
    t.integer "group_id",    limit: 4
  end

  create_table "groups_users", force: :cascade do |t|
    t.integer "user_id",  limit: 4
    t.integer "group_id", limit: 4
  end

  create_table "meterings", force: :cascade do |t|
    t.integer "result", limit: 4
  end

  create_table "pacients", force: :cascade do |t|
    t.string   "analysis_name", limit: 255, null: false
    t.datetime "analysis_date"
  end

  create_table "pacients_doctors", force: :cascade do |t|
    t.integer "doctor_id",  limit: 4
    t.integer "pacient_id", limit: 4
  end

  create_table "url_types", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "url_types", ["name"], name: "index_url_types_on_name", unique: true, using: :btree

  create_table "urls", force: :cascade do |t|
    t.string  "url_pattern", limit: 255
    t.string  "name",        limit: 255
    t.integer "url_type_id", limit: 4
    t.integer "sorder",      limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string  "name",   limit: 30, null: false
    t.integer "passwd", limit: 8,  null: false
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree

end

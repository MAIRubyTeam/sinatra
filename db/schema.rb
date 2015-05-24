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

ActiveRecord::Schema.define(version: 20150524123649) do

  create_table "doctors", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "post10", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "post10", ["name"], name: "index_post10_on_name", unique: true, using: :btree

  create_table "post3", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "post3", ["name"], name: "index_post3_on_name", unique: true, using: :btree

  create_table "post5", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "post5", ["name"], name: "index_post5_on_name", unique: true, using: :btree

  create_table "post8", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "post8", ["name"], name: "index_post8_on_name", unique: true, using: :btree

  create_table "post9", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "post9", ["name"], name: "index_post9_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255
  end

end

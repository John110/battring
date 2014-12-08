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

ActiveRecord::Schema.define(version: 20141203051724) do

  create_table "cards", force: true do |t|
    t.integer  "matching_id"
    t.string   "player_a"
    t.string   "player_b"
    t.string   "result"
    t.string   "next"
    t.string   "book"
    t.integer  "first_battle_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["matching_id"], name: "index_cards_on_matching_id", using: :btree

  create_table "favorites", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["project_id"], name: "index_favorites_on_project_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "matchings", force: true do |t|
    t.string   "name"
    t.string   "owner"
    t.string   "title"
    t.string   "reguration"
    t.datetime "limit"
    t.datetime "start"
    t.text     "memo"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matchings", ["project_id"], name: "index_matchings_on_project_id", using: :btree
  add_index "matchings", ["user_id"], name: "index_matchings_on_user_id", using: :btree

  create_table "participants", force: true do |t|
    t.string   "name"
    t.integer  "matching_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["matching_id"], name: "index_participants_on_matching_id", using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "title"
    t.string   "genre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree

  create_table "tournaments", force: true do |t|
    t.integer  "matching_id"
    t.string   "participants"
    t.datetime "start"
    t.string   "result"
    t.string   "cards"
    t.boolean  "is_second_battle"
    t.integer  "card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournaments", ["card_id"], name: "index_tournaments_on_card_id", using: :btree
  add_index "tournaments", ["matching_id"], name: "index_tournaments_on_matching_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

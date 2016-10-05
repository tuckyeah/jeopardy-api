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

ActiveRecord::Schema.define(version: 20161004140048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "complete",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "clues", force: :cascade do |t|
    t.string   "question"
    t.string   "answer"
    t.boolean  "answered",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "category_id"
    t.integer  "value"
  end

  add_index "clues", ["category_id"], name: "index_clues_on_category_id", using: :btree

  create_table "examples", force: :cascade do |t|
    t.text     "text",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "examples", ["user_id"], name: "index_examples_on_user_id", using: :btree

  create_table "game_clues", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "clue_id"
    t.integer  "response_id"
    t.boolean  "clue_answered", default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "game_clues", ["clue_id"], name: "index_game_clues_on_clue_id", using: :btree
  add_index "game_clues", ["game_id"], name: "index_game_clues_on_game_id", using: :btree
  add_index "game_clues", ["response_id"], name: "index_game_clues_on_response_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.boolean  "over",           default: false
    t.integer  "num_clues",      default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.integer  "num_categories"
  end

  add_index "games", ["user_id"], name: "index_games_on_user_id", using: :btree

  create_table "logics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "user_answer"
    t.integer  "user_id"
    t.boolean  "correct",     default: false
    t.string   "clue_answer"
    t.integer  "clue_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "responses", ["game_id"], name: "index_responses_on_game_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "token",                           null: false
    t.string   "password_digest",                 null: false
    t.boolean  "is_admin",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "score",           default: 0
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

  add_foreign_key "clues", "categories"
  add_foreign_key "examples", "users"
  add_foreign_key "game_clues", "clues"
  add_foreign_key "game_clues", "games"
  add_foreign_key "game_clues", "responses"
  add_foreign_key "games", "users"
  add_foreign_key "responses", "games"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_29_162044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.integer "cells", array: true
    t.integer "public_cells", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_boards_on_player_id"
  end

  create_table "boats", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.integer "size"
    t.integer "from_column"
    t.integer "to_column"
    t.integer "from_row"
    t.integer "to_row"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["board_id"], name: "index_boats_on_board_id"
  end

  create_table "logs", force: :cascade do |t|
    t.string "message"
    t.bigint "match_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "player_id", null: false
    t.index ["match_id"], name: "index_logs_on_match_id"
    t.index ["player_id"], name: "index_logs_on_player_id"
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.bigint "player_playing_id"
    t.datetime "started_at"
    t.index ["player_playing_id"], name: "index_matches_on_player_playing_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "joined_at"
    t.index ["match_id"], name: "index_players_on_match_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "boards", "players"
  add_foreign_key "boats", "boards"
  add_foreign_key "logs", "matches"
  add_foreign_key "logs", "players"
  add_foreign_key "matches", "players", column: "player_playing_id"
  add_foreign_key "players", "matches"
  add_foreign_key "players", "users"
end

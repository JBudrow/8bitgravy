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

ActiveRecord::Schema.define(version: 20160808183941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.integer "xbox_game_id"
    t.string  "name"
    t.string  "url"
    t.date    "time_unlocked"
    t.integer "value"
    t.boolean "unlocked"
    t.boolean "unlocked_online"
    t.text    "description"
    t.boolean "is_secret"
  end

  add_index "achievements", ["xbox_game_id"], name: "index_achievements_on_xbox_game_id", using: :btree

  create_table "steam_achievements", force: :cascade do |t|
    t.integer "steam_game_id"
    t.string  "name"
    t.string  "default_value"
    t.string  "display_name"
    t.string  "description"
    t.string  "icon"
    t.string  "icon_gray"
    t.string  "percent"
    t.integer "hidden"
    t.integer "achieved"
  end

  add_index "steam_achievements", ["steam_game_id"], name: "index_steam_achievements_on_steam_game_id", using: :btree

  create_table "steam_games", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "appid"
    t.integer "playtime_forever"
    t.string  "playtime_2weeks"
    t.string  "img_icon_url"
    t.string  "img_logo_url"
    t.boolean "has_community_visible_stats"
  end

  add_index "steam_games", ["user_id"], name: "index_steam_games_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "xu_gamertag"
    t.string   "xuid",             limit: 16
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "steamid"
    t.string   "steam_gamertag"
    t.string   "steam_vanity_url"
    t.string   "avatar"
    t.string   "avatar_medium"
    t.string   "avatar_full"
  end

  create_table "xbox_games", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "title_id"
    t.date    "last_played"
    t.integer "current_achievements"
    t.integer "current_gamerscore"
    t.integer "total_achievements"
    t.integer "total_gamerscore"
    t.string  "genre"
    t.string  "sub_genre"
    t.string  "developer"
    t.string  "publisher"
    t.date    "release_date"
    t.text    "description"
    t.string  "hex_id"
    t.string  "box_art_url"
    t.string  "banner_url"
  end

  add_index "xbox_games", ["user_id"], name: "index_xbox_games_on_user_id", using: :btree

  add_foreign_key "achievements", "xbox_games"
  add_foreign_key "steam_achievements", "steam_games"
  add_foreign_key "steam_games", "users"
  add_foreign_key "xbox_games", "users"
end

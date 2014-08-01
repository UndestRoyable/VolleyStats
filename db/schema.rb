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

ActiveRecord::Schema.define(version: 20140801105641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coaches", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coaches", ["country_id"], name: "index_coaches_on_country_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "halls", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "halls", ["city_id"], name: "index_halls_on_city_id", using: :btree

  create_table "match_guests", force: true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.integer  "result"
    t.integer  "set1_break1"
    t.integer  "set1_break2"
    t.integer  "set1_break3"
    t.integer  "set2_break1"
    t.integer  "set2_break2"
    t.integer  "set2_break3"
    t.integer  "set3_break1"
    t.integer  "set3_break2"
    t.integer  "set3_break3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_guests", ["match_id"], name: "index_match_guests_on_match_id", using: :btree
  add_index "match_guests", ["team_id"], name: "index_match_guests_on_team_id", using: :btree

  create_table "match_hosts", force: true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.integer  "result"
    t.integer  "set1_break1"
    t.integer  "set1_break2"
    t.integer  "set1_break3"
    t.integer  "set2_break1"
    t.integer  "set2_break2"
    t.integer  "set2_break3"
    t.integer  "set3_break1"
    t.integer  "set3_break2"
    t.integer  "set3_break3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_hosts", ["match_id"], name: "index_match_hosts_on_match_id", using: :btree
  add_index "match_hosts", ["team_id"], name: "index_match_hosts_on_team_id", using: :btree

  create_table "match_referees", force: true do |t|
    t.integer  "match_id"
    t.integer  "referee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_referees", ["match_id"], name: "index_match_referees_on_match_id", using: :btree
  add_index "match_referees", ["referee_id"], name: "index_match_referees_on_referee_id", using: :btree

  create_table "match_set_scores", force: true do |t|
    t.integer  "match_id"
    t.integer  "set_number"
    t.integer  "host_score"
    t.integer  "guest_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_set_scores", ["match_id"], name: "index_match_set_scores_on_match_id", using: :btree

  create_table "matches", force: true do |t|
    t.datetime "date"
    t.integer  "match_host_id"
    t.integer  "match_guest_id"
    t.datetime "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hall_id"
    t.integer  "scout_id"
    t.integer  "first_referee_id"
    t.integer  "second_referee_id"
    t.integer  "spectators"
  end

  add_index "matches", ["match_guest_id"], name: "index_matches_on_match_guest_id", using: :btree
  add_index "matches", ["match_host_id"], name: "index_matches_on_match_host_id", using: :btree

  create_table "player_set_scores", force: true do |t|
    t.integer  "match_set_score_id"
    t.integer  "player_id"
    t.integer  "points_total"
    t.integer  "block_points"
    t.integer  "won_lost"
    t.integer  "serve_total"
    t.integer  "serve_errors"
    t.integer  "serve_aces"
    t.integer  "reception_total"
    t.integer  "reception_errors"
    t.integer  "reception_efficiency"
    t.integer  "attack_total"
    t.integer  "attack_errors"
    t.integer  "attack_blocks"
    t.integer  "attack_points"
    t.integer  "attack_efficiency"
    t.integer  "break_points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "zone"
  end

  add_index "player_set_scores", ["match_set_score_id"], name: "index_player_set_scores_on_match_set_score_id", using: :btree
  add_index "player_set_scores", ["player_id"], name: "index_player_set_scores_on_player_id", using: :btree

  create_table "player_teams", force: true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_teams", ["player_id"], name: "index_player_teams_on_player_id", using: :btree
  add_index "player_teams", ["team_id"], name: "index_player_teams_on_team_id", using: :btree

  create_table "players", force: true do |t|
    t.integer  "team_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "number"
    t.integer  "position_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["country_id"], name: "index_players_on_country_id", using: :btree
  add_index "players", ["position_id"], name: "index_players_on_position_id", using: :btree
  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "positions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referees", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "referees", ["country_id"], name: "index_referees_on_country_id", using: :btree

  create_table "scouts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "scouts", ["email"], name: "index_scouts_on_email", unique: true, using: :btree
  add_index "scouts", ["reset_password_token"], name: "index_scouts_on_reset_password_token", unique: true, using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "number_players"
    t.integer  "coach_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["coach_id"], name: "index_teams_on_coach_id", using: :btree

end

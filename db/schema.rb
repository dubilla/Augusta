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

ActiveRecord::Schema.define(version: 2021_06_18_013253) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "draft_picks", id: :serial, force: :cascade do |t|
    t.integer "player_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "draft_slot_id"
    t.index ["draft_slot_id"], name: "index_draft_picks_on_draft_slot_id"
    t.index ["player_id"], name: "index_draft_picks_on_player_id"
  end

  create_table "draft_slots", force: :cascade do |t|
    t.bigint "draft_id"
    t.bigint "team_id"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["draft_id"], name: "index_draft_slots_on_draft_id"
    t.index ["team_id"], name: "index_draft_slots_on_team_id"
  end

  create_table "drafts", id: :serial, force: :cascade do |t|
    t.integer "league_tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "starts_at"
    t.datetime "completed_at"
  end

  create_table "league_tournaments", id: :serial, force: :cascade do |t|
    t.integer "league_id"
    t.integer "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.integer "external_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "team_id"
    t.index ["external_id"], name: "index_players_on_external_id", unique: true
  end

  create_table "roster_players", id: :serial, force: :cascade do |t|
    t.integer "roster_id"
    t.integer "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "winner"
    t.integer "final_score"
  end

  create_table "rosters", id: :serial, force: :cascade do |t|
    t.integer "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "league_tournament_id"
    t.boolean "winner", default: false
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "league_id"
  end

  create_table "tournaments", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.date "start_date"
    t.integer "external_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "completed", default: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "draft_picks", "draft_slots"
  add_foreign_key "draft_picks", "players"
  add_foreign_key "draft_slots", "drafts"
  add_foreign_key "draft_slots", "teams"
end

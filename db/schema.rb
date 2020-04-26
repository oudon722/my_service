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

ActiveRecord::Schema.define(version: 20200426013412) do

  create_table "cities", force: :cascade do |t|
    t.integer "prefecture_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hoff_relationships", force: :cascade do |t|
    t.integer "hoff_id"
    t.integer "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "activated", default: false
    t.index ["hoff_id", "participant_id"], name: "index_hoff_relationships_on_hoff_id_and_participant_id", unique: true
    t.index ["hoff_id"], name: "index_hoff_relationships_on_hoff_id"
    t.index ["participant_id"], name: "index_hoff_relationships_on_participant_id"
  end

  create_table "hoffs", force: :cascade do |t|
    t.string "name"
    t.datetime "dates"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "required_level"
    t.integer "pt_cost"
    t.integer "max_pt_count"
    t.integer "parking_space"
    t.text "details"
    t.datetime "end_dates"
    t.integer "permit_first_look"
    t.string "station_name"
    t.integer "prefecture_id"
    t.integer "city_id"
    t.index ["name"], name: "index_Hoffs_on_name"
    t.index ["owner_id"], name: "index_Hoffs_on_owner_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "player_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.integer "ssbu_experience"
    t.integer "ssbu_skill"
    t.integer "using_character"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "station_name"
    t.integer "city_id"
    t.integer "prefecture_id"
  end

end

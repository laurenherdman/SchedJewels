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

ActiveRecord::Schema.define(version: 20151221183744) do

  create_table "attendees", force: :cascade do |t|
    t.string   "email_address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "proposal_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "body_text"
    t.integer  "proposal_id"
    t.integer  "user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "google_event_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.date     "start_date"
    t.time     "start_time"
    t.date     "end_date"
    t.time     "end_time"
  end

  create_table "proposals", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "owner_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "event_id"
    t.string   "time_zone"
  end

  create_table "proposals_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "proposal_id"
  end

  create_table "timeslots", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.time     "start_time"
    t.date     "start_date"
    t.time     "end_time"
    t.date     "end_date"
    t.integer  "proposal_id"
    t.string   "time_zone"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "token"
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.string   "refresh_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "timeslot_id"
  end

end

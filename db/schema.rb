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

ActiveRecord::Schema.define(version: 20140104191235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_email_templates", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "booking_emails", force: true do |t|
    t.string "body"
  end

  create_table "bookings", force: true do |t|
    t.integer  "school_teacher_id"
    t.datetime "start_time"
    t.integer  "num_children"
    t.integer  "required_bikes"
    t.integer  "required_helmets"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_teachers", force: true do |t|
    t.string   "name"
    t.string   "school"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "postcode"
    t.string   "telephone_number"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
  end

  create_table "users", force: true do |t|
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
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

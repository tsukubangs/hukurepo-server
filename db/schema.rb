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

ActiveRecord::Schema.define(version: 20171011073115) do

  create_table "problems", force: :cascade do |t|
    t.text     "comment"
    t.string   "image"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id",                               null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "responses_seen",    default: true,      null: false
    t.boolean  "responded",         default: false,     null: false
    t.text     "japanese_comment"
    t.string   "response_priority", default: "default", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.text     "comment"
    t.integer  "problem_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "japanese_comment"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "gender"
    t.integer  "age"
    t.string   "country_of_residence"
    t.string   "image"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "access_token"
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "device_token"
    t.string   "role",                   default: "poster", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

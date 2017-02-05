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

ActiveRecord::Schema.define(version: 20170118212357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instagram_account_media_objects", force: :cascade do |t|
    t.integer  "instagram_account_id"
    t.string   "link"
    t.string   "media_url"
    t.jsonb    "tags"
    t.datetime "created_time"
    t.string   "caption"
    t.string   "media_type"
    t.string   "instagram_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["instagram_account_id"], name: "index_instagram_account_media_objects_on_instagram_account_id", using: :btree
    t.index ["instagram_id"], name: "index_instagram_account_media_objects_on_instagram_id", unique: true, using: :btree
  end

  create_table "instagram_accounts", force: :cascade do |t|
    t.string   "token"
    t.string   "instagram_id"
    t.string   "username"
    t.string   "full_name"
    t.string   "profile_picture"
    t.string   "bio"
    t.string   "website"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["instagram_id"], name: "index_instagram_accounts_on_instagram_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_instagram_accounts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "instagram_token"
    t.string   "instagram_id"
    t.string   "username"
    t.string   "full_name"
    t.string   "profile_picture"
    t.string   "bio"
    t.string   "website"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["instagram_id"], name: "index_users_on_instagram_id", using: :btree
  end

  add_foreign_key "instagram_account_media_objects", "instagram_accounts"
  add_foreign_key "instagram_accounts", "users"
end

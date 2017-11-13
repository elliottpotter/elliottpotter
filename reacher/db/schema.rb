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

ActiveRecord::Schema.define(version: 20170816152207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "clients", force: :cascade do |t|
    t.string   "email"
    t.string   "phone_number"
    t.string   "instagram_username"
    t.string   "instagram_password"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "instagram_post_id"
    t.string   "text"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["client_id"], name: "index_comments_on_client_id", using: :btree
    t.index ["instagram_post_id"], name: "index_comments_on_instagram_post_id", using: :btree
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_follows_on_client_id", using: :btree
    t.index ["user_id"], name: "index_follows_on_user_id", using: :btree
  end

  create_table "instagram_posts", force: :cascade do |t|
    t.string   "url"
    t.string   "short_url"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_instagram_posts_on_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "instagram_post_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["client_id"], name: "index_likes_on_client_id", using: :btree
    t.index ["instagram_post_id"], name: "index_likes_on_instagram_post_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "post_keywords", force: :cascade do |t|
    t.integer  "instagram_post_id"
    t.string   "word"
    t.string   "part_of_speech"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["instagram_post_id"], name: "index_post_keywords_on_instagram_post_id", using: :btree
  end

  create_table "user_followers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "new_followers"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_user_followers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "username"
  end

  add_foreign_key "comments", "clients"
  add_foreign_key "comments", "instagram_posts"
  add_foreign_key "follows", "clients"
  add_foreign_key "follows", "users"
  add_foreign_key "instagram_posts", "users"
  add_foreign_key "likes", "clients"
  add_foreign_key "likes", "instagram_posts"
  add_foreign_key "likes", "users"
  add_foreign_key "post_keywords", "instagram_posts"
  add_foreign_key "user_followers", "users"
end

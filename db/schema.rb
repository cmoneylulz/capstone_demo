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

ActiveRecord::Schema.define(version: 20140316171444) do

  create_table "Ratings", force: true do |t|
    t.integer  "score",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "ratable_id"
    t.string   "ratable_type"
  end

  add_index "Ratings", ["ratable_id", "ratable_type"], name: "index_ratings_on_ratable_id_and_ratable_type"
  add_index "Ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "artist_interest_points", force: true do |t|
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "interest_point_id"
  end

  add_index "artist_interest_points", ["artist_id"], name: "index_artist_interest_points_on_artist_id"
  add_index "artist_interest_points", ["interest_point_id"], name: "index_artist_interest_points_on_interest_point_id"

  create_table "artists", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "author"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commentable_id"
    t.string   "commentable_type"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"

  create_table "images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.integer  "interest_point_id"
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.integer  "contributor_id"
  end

  add_index "images", ["approver_id"], name: "index_images_on_approver_id"
  add_index "images", ["contributor_id"], name: "index_images_on_contributor_id"
  add_index "images", ["interest_point_id"], name: "index_images_on_interest_point_id"

  create_table "interest_points", force: true do |t|
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contributor_id"
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "category_id"
    t.integer  "default_image_id"
  end

  add_index "interest_points", ["approver_id"], name: "index_interest_points_on_approver_id"
  add_index "interest_points", ["category_id"], name: "index_interest_points_on_category_id"
  add_index "interest_points", ["contributor_id"], name: "index_interest_points_on_contributor_id"
  add_index "interest_points", ["default_image_id"], name: "index_interest_points_on_default_image_id"

  create_table "reports", force: true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports", ["comment_id"], name: "index_reports_on_comment_id"
  add_index "reports", ["user_id"], name: "index_reports_on_user_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_hash"
    t.string   "user_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.string   "password_salt"
    t.string   "provider"
    t.string   "uid"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["perishable_token"], name: "index_users_on_perishable_token"
  add_index "users", ["role_id"], name: "index_users_on_role_id"

end

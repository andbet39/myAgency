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

ActiveRecord::Schema.define(version: 20170303161050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interactions", force: :cascade do |t|
    t.string   "inttype"
    t.integer  "vote"
    t.integer  "interest"
    t.text     "note"
    t.integer  "listing_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.index ["listing_id"], name: "index_interactions_on_listing_id", using: :btree
    t.index ["user_id"], name: "index_interactions_on_user_id", using: :btree
  end

  create_table "listings", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.string   "tel"
    t.string   "tel2"
    t.string   "email"
    t.text     "description"
    t.date     "insert_date"
    t.integer  "mt"
    t.string   "zona"
    t.string   "id_annuncio"
    t.string   "origin"
    t.string   "price"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "favourite",   default: false
    t.boolean  "isnew"
    t.integer  "user_id"
  end

  create_table "search_results", force: :cascade do |t|
    t.integer  "search_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_new"
    t.index ["listing_id"], name: "index_search_results_on_listing_id", using: :btree
    t.index ["search_id"], name: "index_search_results_on_search_id", using: :btree
  end

  create_table "searches", force: :cascade do |t|
    t.string   "keyword"
    t.string   "zona"
    t.date     "last_run"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "zone_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  create_table "zones", force: :cascade do |t|
    t.string   "name"
    t.string   "pp_url_part"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "subitourl"
  end

  add_foreign_key "interactions", "listings"
  add_foreign_key "interactions", "users"
  add_foreign_key "search_results", "listings"
  add_foreign_key "search_results", "searches"
end

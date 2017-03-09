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

ActiveRecord::Schema.define(version: 20170309112635) do

  create_table "crono_jobs", force: :cascade do |t|
    t.string   "job_id",                               null: false
    t.text     "log",               limit: 1073741823
    t.datetime "last_performed_at"
    t.boolean  "healthy"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["job_id"], name: "index_crono_jobs_on_job_id", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string   "description"
    t.string   "source"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

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
    t.index ["listing_id"], name: "index_interactions_on_listing_id"
    t.index ["user_id"], name: "index_interactions_on_user_id"
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

  create_table "notifications", force: :cascade do |t|
    t.string   "body"
    t.string   "object_type"
    t.integer  "object_id"
    t.boolean  "notified"
    t.boolean  "seen"
    t.boolean  "emailed"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["object_type", "object_id"], name: "index_notifications_on_object_type_and_object_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "avatarimg_url"
    t.string   "agenzia"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  create_table "search_results", force: :cascade do |t|
    t.integer  "search_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_new"
    t.index ["listing_id"], name: "index_search_results_on_listing_id"
    t.index ["search_id"], name: "index_search_results_on_search_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string   "keyword"
    t.string   "zona"
    t.datetime "last_run"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "zone_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "profile_id"
    t.boolean  "is_pro",                 default: false
    t.string   "stripe_token"
    t.datetime "pro_end_date"
    t.string   "stripe_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
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
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  create_table "zones", force: :cascade do |t|
    t.string   "name"
    t.string   "pp_url_part"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "subitourl"
  end

end

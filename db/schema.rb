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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130509034608) do

  create_table "applications", :force => true do |t|
    t.string   "name"
    t.string   "lastPosition"
    t.string   "lastTitle"
    t.string   "phone"
    t.string   "email"
    t.text     "resume"
    t.text     "links"
    t.integer  "job_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "companyDescription"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "logo_url"
  end

  add_index "companies", ["name"], :name => "index_companies_on_name"

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "expiration_date"
    t.integer  "category_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "company_id"
    t.integer  "location_id"
    t.string   "application_url"
    t.string   "job_email"
  end

  add_index "jobs", ["category_id"], :name => "index_jobs_on_category_id"
  add_index "jobs", ["company_id"], :name => "index_jobs_on_company_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "locations", ["name"], :name => "index_locations_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "company_id"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

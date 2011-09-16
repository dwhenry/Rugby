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

ActiveRecord::Schema.define(:version => 20110916122741) do

  create_table "league_members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "admin_id"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.date     "match_date"
    t.float    "kick_off"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.string   "location"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "picks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "pick"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "match_id"
    t.integer  "home_team"
    t.integer  "away_team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "pool"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  create_table "users", :force => true do |t|
    t.integer  "team_id"
    t.string   "login",                                  :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "admin",               :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

end

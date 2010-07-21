# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100721133530) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "url_id"
    t.string   "verb"
    t.string   "title"
    t.text     "summary"
    t.string   "lang"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.boolean  "is_public"
    t.string   "public_name"
  end

  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "activity_objects", :force => true do |t|
    t.integer  "activity_id"
    t.string   "type"
    t.string   "url_id"
    t.string   "title"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "object_type"
  end

  add_index "activity_objects", ["activity_id"], :name => "index_activity_objects_on_activity_id"
  add_index "activity_objects", ["type"], :name => "index_activity_objects_on_type"

  create_table "consumer_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consumer_tokens", ["token"], :name => "index_consumer_tokens_on_token", :unique => true

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end

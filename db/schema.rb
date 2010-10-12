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

ActiveRecord::Schema.define(:version => 20101012141156) do

  create_table "assets", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.string   "email"
    t.text     "content"
    t.integer  "usefulness", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id", "user_id"], :name => "index_comments_on_post_id_and_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.string   "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["locked_by"], :name => "index_delayed_jobs_on_locked_by"

  create_table "feeds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "object_id"
    t.integer  "kind"
    t.string   "cache_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logged_exceptions", :force => true do |t|
    t.string   "exception_class"
    t.string   "controller_name"
    t.string   "action_name"
    t.text     "message"
    t.text     "backtrace"
    t.text     "environment"
    t.text     "request"
    t.datetime "created_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.text     "content"
    t.boolean  "mail_me_comments", :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "comments_count",   :default => 0
    t.string   "title"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

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
    t.string   "godfather_email"
    t.boolean  "activate",                                 :default => false
    t.string   "activation_code"
    t.string   "email_activation_code"
    t.string   "new_email"
    t.datetime "last_activity"
    t.integer  "posts_count",                              :default => 0
    t.integer  "comments_count",                           :default => 0
    t.string   "status",                                   :default => ""
    t.integer  "gender",                                   :default => -1
    t.string   "organization"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end

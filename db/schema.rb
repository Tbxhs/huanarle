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

ActiveRecord::Schema.define(:version => 20120615082236) do

  create_table "blogs", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blogs", ["user_id"], :name => "index_blogs_on_user_id"

  create_table "categories", :force => true do |t|
    t.integer  "parent_id",  :default => 0
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "consumptions", :force => true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.decimal  "cost",        :precision => 10, :scale => 2, :default => 0.0
    t.integer  "subject_id"
    t.integer  "user_id"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
  end

  add_index "consumptions", ["category_id"], :name => "index_consumptions_on_category_id"
  add_index "consumptions", ["subject_id"], :name => "index_consumptions_on_subject_id"
  add_index "consumptions", ["user_id"], :name => "index_consumptions_on_user_id"

  create_table "executers", :force => true do |t|
    t.string   "task_title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "do_times"
    t.integer  "done_times"
  end

  add_index "executers", ["task_title"], :name => "index_executers_on_task_title"

  create_table "subjects", :force => true do |t|
    t.string   "title"
    t.string   "remarks"
    t.decimal  "total",              :precision => 10, :scale => 2, :default => 0.0
    t.integer  "consumptions_count"
    t.integer  "user_id"
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  add_index "subjects", ["user_id"], :name => "index_subjects_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login",              :limit => 40
    t.string   "email",              :limit => 40
    t.string   "password_digest"
    t.string   "avatar"
    t.datetime "last_login_at"
    t.integer  "consumptions_count",               :default => 0
    t.integer  "subjects_count",                   :default => 0
    t.integer  "recorded_days",                    :default => 0
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "weibo_uid"
    t.string   "weibo_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end

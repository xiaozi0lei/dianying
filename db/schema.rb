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

ActiveRecord::Schema.define(:version => 20141202084715) do

  create_table "articles", :force => true do |t|
    t.string   "title",      :limit => 510
    t.text     "text"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "picture",    :limit => 510
    t.integer  "user_id"
    t.boolean  "sticky"
    t.string   "slug"
  end

  add_index "articles", ["slug"], :name => "index_articles_on_slug"

  create_table "comments", :force => true do |t|
    t.string   "commenter",  :limit => 510
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "pictures", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", :limit => 510
    t.integer  "tagger_id"
    t.string   "tagger_type",   :limit => 510
    t.string   "context",       :limit => 256
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_tag_id_taggable_id_taggable_type_context_tagger_id_key", :unique => true

  create_table "tags", :force => true do |t|
    t.string  "name",           :limit => 510
    t.integer "taggings_count",                :default => 0
  end

  add_index "tags", ["name"], :name => "tags_name_key", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name",          :limit => 510
    t.string   "email",         :limit => 510
    t.string   "password_hash", :limit => 510
    t.string   "password_salt", :limit => 510
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

end

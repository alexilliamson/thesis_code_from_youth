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

ActiveRecord::Schema.define(:version => 20130602195309) do

  create_table "page2s", :force => true do |t|
    t.text     "text"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "person2_id"
  end

  add_index "page2s", ["person2_id"], :name => "index_page2s_on_person2_id"

  create_table "page2s_word2s", :id => false, :force => true do |t|
    t.integer "page2_id"
    t.integer "word2_id"
  end

  add_index "page2s_word2s", ["page2_id"], :name => "index_page2s_word2s_on_page2_id"
  add_index "page2s_word2s", ["word2_id", "page2_id"], :name => "index_page2s_word2s_on_word2_id_and_page2_id"

  create_table "pages", :force => true do |t|
    t.integer  "person_id"
    t.text     "text"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pages", ["person_id"], :name => "index_pages_on_person_id"

  create_table "pages_words", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "word_id"
  end

  add_index "pages_words", ["page_id"], :name => "index_pages_words_on_page_id"
  add_index "pages_words", ["word_id", "page_id"], :name => "index_pages_words_on_word_id_and_page_id"

  create_table "paper2s", :force => true do |t|
    t.string   "name"
    t.integer  "year"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "paper_use2s", :force => true do |t|
    t.string   "stem"
    t.integer  "paper2_id"
    t.integer  "frequency"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "paper_uses", :force => true do |t|
    t.integer  "paper_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "stem"
    t.integer  "frequency"
  end

  create_table "papers", :force => true do |t|
    t.string   "name"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "branch"
    t.string   "party"
    t.float    "score1"
    t.float    "score2"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year"
  end

  add_index "people", ["branch"], :name => "index_people_on_branch"
  add_index "people", ["name", "year", "branch"], :name => "index_people_on_name_and_year_and_branch"
  add_index "people", ["score1"], :name => "index_people_on_score1"
  add_index "people", ["year"], :name => "index_people_on_year"

  create_table "person2s", :force => true do |t|
    t.string   "name"
    t.string   "branch"
    t.string   "party"
    t.float    "score1"
    t.float    "score2"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year"
  end

  add_index "person2s", ["branch"], :name => "index_person2s_on_branch"
  add_index "person2s", ["name", "branch"], :name => "index_person2s_on_name_and_branch"

  create_table "phrases", :force => true do |t|
    t.string   "stem"
    t.float    "chi2"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.float    "chi2b"
    t.integer  "uses_count", :default => 0
  end

  add_index "phrases", ["chi2"], :name => "index_phrases_on_chi2"
  add_index "phrases", ["chi2b"], :name => "index_phrases_on_chi2b"

  create_table "word2s", :force => true do |t|
    t.string   "stem"
    t.string   "text"
    t.string   "branch"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "chi2"
    t.float    "chib"
  end

  add_index "word2s", ["branch"], :name => "index_word2s_on_branch"
  add_index "word2s", ["stem", "branch"], :name => "index_word2s_on_stem_and_branch"

  create_table "words", :force => true do |t|
    t.string   "stem"
    t.string   "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "branch"
    t.float    "chi2"
    t.float    "chib"
  end

  add_index "words", ["branch"], :name => "index_words_on_branch"
  add_index "words", ["stem", "branch"], :name => "index_words_on_stem_and_branch"

end

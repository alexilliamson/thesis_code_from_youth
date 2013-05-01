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

ActiveRecord::Schema.define(:version => 20130429073153) do

  create_table "passages", :force => true do |t|
    t.text     "text"
    t.integer  "speaker_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  add_index "passages", ["speaker_id"], :name => "index_passages_on_speaker_id"

  create_table "phrases", :force => true do |t|
    t.string   "stem"
    t.float    "chi2"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "phrases", ["stem", "year"], :name => "index_phrases_on_stem_and_year"

  create_table "results", :force => true do |t|
    t.integer  "phrase_id"
    t.float    "intercept"
    t.float    "slope"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "slope2"
  end

  add_index "results", ["phrase_id"], :name => "index_results_on_phrase_id"

  create_table "speakers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "party"
    t.integer  "year"
    t.float    "score"
    t.string   "branch"
    t.float    "score2"
  end

  add_index "speakers", ["name", "year", "branch"], :name => "index_speakers_on_name_and_year_and_branch"
  add_index "speakers", ["party"], :name => "index_speakers_on_party"
  add_index "speakers", ["year"], :name => "index_speakers_on_year"

  create_table "uses", :force => true do |t|
    t.string   "text"
    t.integer  "passage_id"
    t.integer  "phrase_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "uses", ["passage_id"], :name => "index_uses_on_passage_id"
  add_index "uses", ["phrase_id"], :name => "index_uses_on_phrase_id"

end

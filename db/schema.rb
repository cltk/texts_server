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

ActiveRecord::Schema.define(version: 20170830024010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "language_id"
    t.index ["language_id"], name: "index_authors_on_language_id"
  end

  create_table "corpora", force: :cascade do |t|
    t.string "link"
    t.string "slug", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "language_id"
    t.index ["language_id"], name: "index_corpora_on_language_id"
  end

  create_table "entity_map_entries", force: :cascade do |t|
    t.integer "key", null: false
    t.json "data"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "work_id"
    t.index ["key", "work_id"], name: "index_entity_map_entries_on_key_and_work_id", unique: true
    t.index ["work_id"], name: "index_entity_map_entries_on_work_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_languages_on_slug", unique: true
  end

  create_table "text_nodes", force: :cascade do |t|
    t.integer "index", null: false
    t.integer "location", default: [], null: false, array: true
    t.json "data"
    t.json "entity_ranges", default: [], null: false, array: true
    t.json "inline_style_ranges", default: [], null: false, array: true
    t.string "text_node_type", default: "unstyled", null: false
    t.string "key", null: false
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.bigint "corpus_id"
    t.bigint "language_id"
    t.bigint "work_id"
    t.bigint "user_id"
    t.index ["author_id"], name: "index_text_nodes_on_author_id"
    t.index ["corpus_id"], name: "index_text_nodes_on_corpus_id"
    t.index ["key", "work_id"], name: "index_text_nodes_on_key_and_work_id", unique: true
    t.index ["language_id"], name: "index_text_nodes_on_language_id"
    t.index ["user_id"], name: "index_text_nodes_on_user_id"
    t.index ["work_id"], name: "index_text_nodes_on_work_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "facebook_access_token"
    t.string "google_access_token"
    t.string "google_refresh_token"
    t.string "twitter_oauth_token"
    t.string "twitter_oauth_token_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.string "edition"
    t.string "english_title"
    t.string "filename"
    t.string "form"
    t.string "md5_hash"
    t.string "original_title", null: false
    t.string "slug", null: false
    t.string "structure"
    t.string "urn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.bigint "corpus_id"
    t.bigint "language_id"
    t.index ["author_id"], name: "index_works_on_author_id"
    t.index ["corpus_id"], name: "index_works_on_corpus_id"
    t.index ["language_id"], name: "index_works_on_language_id"
    t.index ["urn"], name: "index_works_on_urn", unique: true
  end

  add_foreign_key "authors", "languages"
  add_foreign_key "corpora", "languages"
  add_foreign_key "entity_map_entries", "works"
  add_foreign_key "text_nodes", "authors"
  add_foreign_key "text_nodes", "corpora"
  add_foreign_key "text_nodes", "languages"
  add_foreign_key "text_nodes", "works"
  add_foreign_key "works", "authors"
  add_foreign_key "works", "corpora"
  add_foreign_key "works", "languages"
end

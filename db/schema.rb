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

ActiveRecord::Schema.define(version: 20170728024652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "language", null: false
    t.string "englishname"
    t.string "originalname", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "corpora", force: :cascade do |t|
    t.string "language", null: false
    t.string "link"
    t.string "slug", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "text_nodes", force: :cascade do |t|
    t.integer "index", null: false
    t.integer "location", default: [], null: false, array: true
    t.json "data"
    t.json "entity_ranges", default: [], null: false, array: true
    t.json "inline_style_ranges", default: [], null: false, array: true
    t.string "type", default: "unstyled", null: false
    t.string "key", null: false
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.bigint "corpus_id"
    t.bigint "language_id"
    t.index ["author_id"], name: "index_text_nodes_on_author_id"
    t.index ["corpus_id"], name: "index_text_nodes_on_corpus_id"
    t.index ["language_id"], name: "index_text_nodes_on_language_id"
  end

  add_foreign_key "text_nodes", "authors"
  add_foreign_key "text_nodes", "corpora"
  add_foreign_key "text_nodes", "languages"
end

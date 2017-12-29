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

ActiveRecord::Schema.define(version: 20171229173132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer "frontend_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "moves", force: :cascade do |t|
    t.string "bearing"
    t.integer "x"
    t.integer "y"
    t.bigint "snake_head_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["snake_head_id"], name: "index_moves_on_snake_head_id"
  end

  create_table "snake_heads", force: :cascade do |t|
    t.string "bearing"
    t.integer "x"
    t.integer "y"
    t.bigint "game_id"
    t.index ["game_id"], name: "index_snake_heads_on_game_id"
  end

  create_table "tails", force: :cascade do |t|
    t.string "bearing"
    t.integer "x"
    t.integer "y"
    t.bigint "snake_head_id"
    t.integer "next_move_index"
    t.index ["snake_head_id"], name: "index_tails_on_snake_head_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "high_score"
  end

  add_foreign_key "games", "users"
  add_foreign_key "moves", "snake_heads"
  add_foreign_key "snake_heads", "games"
  add_foreign_key "tails", "snake_heads"
end

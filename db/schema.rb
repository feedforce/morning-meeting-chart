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

ActiveRecord::Schema.define(version: 20160813141505) do

  create_table "goals", force: :cascade do |t|
    t.date     "date"
    t.integer  "goal"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_goals_on_team_id"
  end

  create_table "progresses", force: :cascade do |t|
    t.date     "start_date"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "end_date"
    t.integer  "goal_id"
    t.index ["goal_id"], name: "index_progresses_on_goal_id"
  end

  create_table "shared_infos", force: :cascade do |t|
    t.string   "title"
    t.string   "owner"
    t.string   "body"
    t.date     "announce_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "entity",     default: 0
    t.integer  "order"
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "progress_id"
    t.string   "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["progress_id"], name: "index_topics_on_progress_id"
  end

end

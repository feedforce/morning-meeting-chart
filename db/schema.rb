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

ActiveRecord::Schema.define(version: 20160719112257) do

  create_table "progresses", force: :cascade do |t|
    t.integer  "team_id"
    t.date     "start_date"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_progresses_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "goal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "entity"
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "progress_id"
    t.string   "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["progress_id"], name: "index_topics_on_progress_id"
  end

end

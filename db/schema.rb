# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 4) do

  create_table "facts", force: :cascade do |t|
    t.string "fact"
    t.string "true_or_false"
  end

  create_table "games", force: :cascade do |t|
    t.integer "score"
    t.string "username"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "fact_id"
    t.integer "game_id"
    t.boolean "answered_correctly"
  end

end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_04_17_171456) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reports", force: :cascade do |t|
    t.string "nickname"
    t.float "energy_consumption"
    t.float "energy_cost"
    t.string "state"
    t.float "state_residential_avg"
    t.float "state_industrial_avg"
    t.float "state_commercial_avg"
    t.float "zip_residential_avg"
    t.float "zip_industrial_avg"
    t.float "zip_commercial_avg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "report_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["report_id"], name: "index_user_reports_on_report_id"
    t.index ["user_id"], name: "index_user_reports_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "user_reports", "reports"
  add_foreign_key "user_reports", "users"
end

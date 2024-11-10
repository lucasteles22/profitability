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

ActiveRecord::Schema[8.0].define(version: 2024_11_09_171054) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "reports", force: :cascade do |t|
    t.string "kind", limit: 50, null: false
    t.date "date", null: false
    t.string "report_type", limit: 100, null: false
    t.string "product", limit: 1000, null: false
    t.string "broker", limit: 200, null: false
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 8, scale: 2, null: false
    t.decimal "total_value", precision: 8, scale: 2, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "kind", "date", "report_type", "product", "broker", "quantity"], name: "idx_on_user_id_kind_date_report_type_product_broker_0a53e09fd6", unique: true
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "reports", "users"
  add_foreign_key "sessions", "users"
end

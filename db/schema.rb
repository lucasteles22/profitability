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

ActiveRecord::Schema[8.0].define(version: 2025_02_01_200408) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "tradings", force: :cascade do |t|
    t.string "kind"
    t.date "trading_date"
    t.string "market_type"
    t.string "code"
    t.text "broker"
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "total_value"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "kind", "trading_date", "market_type", "code", "broker", "quantity", "unit_price", "total_value"], name: "idx_on_user_id_kind_trading_date_market_type_code_b_3d2c25e34b", unique: true
    t.index ["user_id"], name: "index_tradings_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "kind", limit: 50, null: false
    t.date "transaction_date", null: false
    t.string "transaction_type", limit: 100, null: false
    t.string "product", limit: 1000, null: false
    t.string "broker", limit: 200, null: false
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 8, scale: 2, null: false
    t.decimal "total_value", precision: 8, scale: 2, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "kind", "transaction_date", "transaction_type", "product", "broker", "quantity", "unit_price", "total_value"], name: "idx_on_user_id_kind_transaction_date_transaction_ty_0d53b55bbe", unique: true
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "tradings", "users"
  add_foreign_key "transactions", "users"
end

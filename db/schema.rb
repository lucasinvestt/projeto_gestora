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

ActiveRecord::Schema.define(version: 2022_02_10_202849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cash_transactions", force: :cascade do |t|
    t.string "description"
    t.date "date"
    t.float "value"
    t.bigint "funds_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["funds_id"], name: "index_cash_transactions_on_funds_id"
  end

  create_table "close_prices", force: :cascade do |t|
    t.date "date"
    t.float "value"
    t.bigint "securities_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["securities_id"], name: "index_close_prices_on_securities_id"
  end

  create_table "funds", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "securities", force: :cascade do |t|
    t.string "name"
    t.string "security_type"
    t.string "isin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "security_transactions", force: :cascade do |t|
    t.date "date"
    t.integer "amount"
    t.float "unit_value"
    t.bigint "funds_id", null: false
    t.bigint "securities_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["funds_id"], name: "index_security_transactions_on_funds_id"
    t.index ["securities_id"], name: "index_security_transactions_on_securities_id"
  end

  add_foreign_key "cash_transactions", "funds", column: "funds_id"
  add_foreign_key "close_prices", "securities", column: "securities_id"
  add_foreign_key "security_transactions", "funds", column: "funds_id"
  add_foreign_key "security_transactions", "securities", column: "securities_id"
end

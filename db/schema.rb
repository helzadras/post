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

ActiveRecord::Schema[7.1].define(version: 2024_01_08_124620) do
  create_table "acc_transactions", force: :cascade do |t|
    t.date "date"
    t.string "source"
    t.string "description"
    t.decimal "amount"
    t.integer "user_id", null: false
    t.integer "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_acc_transactions_on_account_id"
    t.index ["user_id"], name: "index_acc_transactions_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.decimal "current_balance"
    t.decimal "available_balance"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "exp_transactions", force: :cascade do |t|
    t.date "date"
    t.string "source"
    t.string "description"
    t.decimal "amount"
    t.integer "user_id"
    t.integer "account_id"
    t.integer "expense_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_exp_transactions_on_account_id"
    t.index ["expense_id"], name: "index_exp_transactions_on_expense_id"
    t.index ["user_id"], name: "index_exp_transactions_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "creditor"
    t.string "purpose"
    t.decimal "initial_balance"
    t.decimal "interest"
    t.decimal "funds"
    t.integer "due_date"
    t.integer "terms"
    t.decimal "amount_due"
    t.bigint "account_id"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "current_balance"
    t.decimal "budget"
    t.decimal "default_fund_amount"
    t.index ["account_id"], name: "index_expenses_on_account_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.date "date"
    t.string "source"
    t.string "description"
    t.decimal "amount"
    t.integer "user_id", null: false
    t.integer "account_id", default: 0, null: false
    t.integer "expense_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["expense_id"], name: "index_transactions_on_expense_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "acc_transactions", "accounts"
  add_foreign_key "acc_transactions", "users"
  add_foreign_key "accounts", "users", on_delete: :cascade
  add_foreign_key "exp_transactions", "accounts"
  add_foreign_key "exp_transactions", "expenses"
  add_foreign_key "exp_transactions", "users"
  add_foreign_key "expenses", "accounts", on_delete: :cascade
  add_foreign_key "expenses", "users", on_delete: :cascade
  add_foreign_key "transactions", "accounts", on_delete: :cascade
  add_foreign_key "transactions", "expenses", on_delete: :cascade
  add_foreign_key "transactions", "users", on_delete: :cascade
end

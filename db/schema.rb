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

ActiveRecord::Schema[7.0].define(version: 2024_05_22_095410) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "key", default: 0
    t.string "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.string "name", null: false
    t.integer "brand", null: false
    t.string "purpose", default: ""
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer "money"
    t.string "comment"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "per_months", force: :cascade do |t|
    t.integer "month", null: false
    t.integer "year", null: false
    t.integer "spend_money", null: false
    t.integer "income_money", null: false
    t.integer "sum_money", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_per_months_on_user_id"
  end

  create_table "spend_genres", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_spend_genres_on_user_id"
  end

  create_table "spends", force: :cascade do |t|
    t.integer "money", null: false
    t.string "comment", null: false
    t.integer "user_id", null: false
    t.integer "spend_genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spend_genre_id"], name: "index_spends_on_spend_genre_id"
    t.index ["user_id"], name: "index_spends_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sex", null: false
    t.string "name", null: false
    t.integer "age", null: false
    t.integer "job", null: false
    t.integer "money", default: 0
    t.integer "alert"
    t.integer "save_money", default: 0
    t.boolean "is_smoker", default: false
    t.boolean "is_unsubscribed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "users"
  add_foreign_key "incomes", "users"
  add_foreign_key "per_months", "users"
  add_foreign_key "spend_genres", "users"
  add_foreign_key "spends", "spend_genres"
  add_foreign_key "spends", "users"
end

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

ActiveRecord::Schema[8.1].define(version: 2026_10_25_102651) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "employment_histories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company_name"
    t.string "designation"
    t.decimal "salary"
    t.string "currency"
    t.date "started_on"
    t.date "ended_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_employment_histories_on_user_id"
  end

  create_table "past_checks", force: :cascade do |t|
    t.bigint "employment_history_id", null: false
    t.jsonb "audited_changes"
    t.datetime "audited_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employment_history_id"], name: "index_past_checks_on_employment_history_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salary_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "compensation"
    t.string "currency"
    t.date "effective_from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["role_id"], name: "index_salary_records_on_role_id"
    t.index ["user_id"], name: "index_salary_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "role_id", null: false
    t.date "hire_date"
    t.string "country_code"
    t.string "primary_contact_number"
    t.string "emergency_contact_number"
    t.text "address"
    t.string "blood_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "employment_histories", "users"
  add_foreign_key "past_checks", "employment_histories"
  add_foreign_key "salary_records", "roles"
  add_foreign_key "salary_records", "users"
  add_foreign_key "users", "roles"
end

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

ActiveRecord::Schema.define(version: 2020_11_29_210932) do

  create_table "area_managers", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.integer "marketing_manager_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_id"], name: "index_area_managers_on_employer_id"
    t.index ["marketing_manager_id"], name: "index_area_managers_on_marketing_manager_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "client_id"
  end

  create_table "cs_managers", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.integer "general_manager_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_id"], name: "index_cs_managers_on_employer_id"
    t.index ["general_manager_id"], name: "index_cs_managers_on_general_manager_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_employers_on_email", unique: true
  end

  create_table "general_managers", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_id"], name: "index_general_managers_on_employer_id"
  end

  create_table "marketing_managers", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.integer "cs_manager_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cs_manager_id"], name: "index_marketing_managers_on_cs_manager_id"
    t.index ["employer_id"], name: "index_marketing_managers_on_employer_id"
  end

  create_table "medical_reps", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.integer "area_manager_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_manager_id"], name: "index_medical_reps_on_area_manager_id"
    t.index ["employer_id"], name: "index_medical_reps_on_employer_id"
  end

  create_table "pars", force: :cascade do |t|
    t.integer "employer_id", null: false
    t.string "par_type"
    t.text "description"
    t.string "status"
    t.integer "charged_person"
    t.text "comments"
    t.integer "value"
    t.integer "client_id"
    t.string "client_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "track_status"
    t.boolean "modified", default: true
    t.string "requester"
    t.index ["employer_id"], name: "index_pars_on_employer_id"
  end

  add_foreign_key "area_managers", "employers"
  add_foreign_key "area_managers", "marketing_managers"
  add_foreign_key "cs_managers", "employers"
  add_foreign_key "cs_managers", "general_managers"
  add_foreign_key "general_managers", "employers"
  add_foreign_key "marketing_managers", "cs_managers"
  add_foreign_key "marketing_managers", "employers"
  add_foreign_key "medical_reps", "area_managers"
  add_foreign_key "medical_reps", "employers"
  add_foreign_key "pars", "employers"
end

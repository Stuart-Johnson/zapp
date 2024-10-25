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

ActiveRecord::Schema[7.2].define(version: 2024_10_25_001622) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.date "birth_date"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "species_id"
    t.index ["species_id"], name: "index_animals_on_species_id"
  end

  create_table "diet_entries", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.bigint "food_id", null: false
    t.jsonb "meals", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_diet_entries_on_animal_id"
    t.index ["food_id"], name: "index_diet_entries_on_food_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.string "supplier"
    t.string "storage_location"
    t.boolean "treat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "diet_type"
  end

  add_foreign_key "animals", "species"
  add_foreign_key "diet_entries", "animals"
  add_foreign_key "diet_entries", "foods"
end

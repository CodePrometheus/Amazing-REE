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

ActiveRecord::Schema[7.0].define(version: 2022_06_25_073803) do
  create_table "addresses", charset: "utf8mb3", force: :cascade do |t|
    t.integer "user_id"
    t.string "address_type"
    t.string "contact_name"
    t.string "cellphone"
    t.string "address"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "address_type"], name: "index_addresses_on_user_id_and_address_type"
  end

  create_table "categories", charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.integer "weight", default: 0
    t.integer "products_counter", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["title"], name: "index_categories_on_title"
  end

  create_table "product_images", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "product_id"
    t.integer "weight", default: 0
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "weight"], name: "index_product_images_on_product_id_and_weight"
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "products", charset: "utf8mb3", force: :cascade do |t|
    t.integer "category_id"
    t.string "title"
    t.string "status", default: "off"
    t.integer "amount", default: 0
    t.string "uuid"
    t.decimal "msrp", precision: 10, scale: 2
    t.decimal "price", precision: 10, scale: 2
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["status", "category_id"], name: "index_products_on_status_and_category_id"
    t.index ["title"], name: "index_products_on_title"
    t.index ["uuid"], name: "index_products_on_uuid", unique: true
  end

  create_table "shopping_carts", charset: "utf8mb3", force: :cascade do |t|
    t.integer "user_id"
    t.string "user_uuid"
    t.integer "product_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shopping_carts_on_user_id"
    t.index ["user_uuid"], name: "index_shopping_carts_on_user_uuid"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "uuid"
    t.integer "default_address_id"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

end

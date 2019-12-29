# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20191228093621) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "prefecture_id"
    t.string   "city",           default: "", null: false
    t.string   "postal_code",                 null: false
    t.string   "street",         default: "", null: false
    t.string   "building_name"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "phone_optional"
    t.index ["user_id"], name: "index_addresses_on_user_id", using: :btree
  end

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",     null: false
    t.string   "customer_id", null: false
    t.string   "card_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "image",      null: false
    t.integer  "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_images_on_product_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                           null: false
    t.integer  "price",                          null: false
    t.integer  "user_id",                        null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "description",      limit: 65535, null: false
    t.string   "condition",                      null: false
    t.string   "delivery_cost",                  null: false
    t.string   "delivery_origin",                null: false
    t.string   "preparatory_days",               null: false
    t.index ["name"], name: "index_products_on_name", using: :btree
    t.index ["user_id"], name: "index_products_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "name",                                 default: "", null: false
    t.string   "avatar"
    t.text     "introduction",           limit: 65535
    t.string   "lastname",                             default: "", null: false
    t.string   "firstname",                            default: "", null: false
    t.string   "lastname_kana",                        default: "", null: false
    t.string   "firstname_kana",                       default: "", null: false
    t.integer  "birth_year",                           default: 0,  null: false
    t.integer  "birth_month",                          default: 0,  null: false
    t.integer  "birth_day",                            default: 0,  null: false
    t.string   "phone"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["phone"], name: "index_users_on_phone", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "images", "products"
  add_foreign_key "products", "users"
end

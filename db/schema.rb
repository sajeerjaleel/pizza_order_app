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

ActiveRecord::Schema[7.0].define(version: 2023_05_11_094421) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discounts", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.float "discount_percentage"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_pizzas", force: :cascade do |t|
    t.uuid "order_id"
    t.bigint "pizza_id"
    t.bigint "size_id"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_pizzas_on_order_id"
    t.index ["pizza_id"], name: "index_order_pizzas_on_pizza_id"
    t.index ["size_id"], name: "index_order_pizzas_on_size_id"
  end

  create_table "order_toppings", force: :cascade do |t|
    t.bigint "order_pizza_id"
    t.bigint "topping_id"
    t.boolean "add"
    t.boolean "remove"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_pizza_id"], name: "index_order_toppings_on_order_pizza_id"
    t.index ["topping_id"], name: "index_order_toppings_on_topping_id"
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "state"
    t.string "customer_name"
    t.decimal "total_price", precision: 10, scale: 2
    t.bigint "discount_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_id"], name: "index_orders_on_discount_id"
  end

  create_table "orders_promotions", force: :cascade do |t|
    t.uuid "order_id", null: false
    t.bigint "promotion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_orders_promotions_on_order_id"
    t.index ["promotion_id"], name: "index_orders_promotions_on_promotion_id"
  end

  create_table "pizzas", force: :cascade do |t|
    t.string "name"
    t.decimal "base_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.bigint "target_id", null: false
    t.bigint "target_size_id", null: false
    t.integer "from"
    t.integer "to"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_id"], name: "index_promotions_on_target_id"
    t.index ["target_size_id"], name: "index_promotions_on_target_size_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name"
    t.decimal "multiplier", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "toppings", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_pizzas", "orders"
  add_foreign_key "order_pizzas", "pizzas"
  add_foreign_key "order_pizzas", "sizes"
  add_foreign_key "order_toppings", "order_pizzas"
  add_foreign_key "order_toppings", "toppings"
  add_foreign_key "orders", "discounts"
  add_foreign_key "orders_promotions", "orders"
  add_foreign_key "orders_promotions", "promotions"
  add_foreign_key "promotions", "pizzas", column: "target_id"
  add_foreign_key "promotions", "sizes", column: "target_size_id"
end

# frozen_string_literal: true

class CreateOrderToppings < ActiveRecord::Migration[7.0]
  def change
    create_table :order_toppings do |t|
      t.references :order_pizza, foreign_key: true
      t.references :topping, foreign_key: true
      t.boolean :add
      t.boolean :remove
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end

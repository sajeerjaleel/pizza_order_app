# frozen_string_literal: true

class CreateOrderPizzas < ActiveRecord::Migration[7.0]
  def change
    create_table :order_pizzas do |t|
      t.references :order, type: :uuid, foreign_key: true
      t.references :pizza, foreign_key: true
      t.references :size, foreign_key: true
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end

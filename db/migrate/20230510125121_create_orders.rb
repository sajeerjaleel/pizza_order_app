# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.integer :state
      t.string :customer_name
      t.decimal :total_price, precision: 10, scale: 2
      t.references :discount, foreign_key: true
      t.timestamps
    end
  end
end

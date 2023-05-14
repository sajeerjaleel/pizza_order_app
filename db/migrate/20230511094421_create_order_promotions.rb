# frozen_string_literal: true

class CreateOrderPromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :orders_promotions do |t|
      t.references :order, type: :uuid, null: false, foreign_key: true
      t.references :promotion, null: false, foreign_key: true
      t.timestamps
    end
  end
end

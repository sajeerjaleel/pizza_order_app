# frozen_string_literal: true

class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :code
      t.references :target, null: false, foreign_key: { to_table: :pizzas }
      t.references :target_size, null: false, foreign_key: { to_table: :sizes }
      t.integer :from
      t.integer :to
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end

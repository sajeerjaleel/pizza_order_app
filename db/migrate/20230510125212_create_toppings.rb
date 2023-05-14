# frozen_string_literal: true

class CreateToppings < ActiveRecord::Migration[7.0]
  def change
    create_table :toppings do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end

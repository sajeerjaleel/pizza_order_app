# frozen_string_literal: true

class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.string :name
      t.string :code
      t.float :discount_percentage
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end

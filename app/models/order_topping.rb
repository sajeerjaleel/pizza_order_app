# frozen_string_literal: true

class OrderTopping < ApplicationRecord
  belongs_to :order_pizza
  belongs_to :topping

  after_save :update_order_pizza_price

  def update_order_pizza_price
    order_pizza.update_price
  end
end

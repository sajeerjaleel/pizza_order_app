# frozen_string_literal: true

class OrderPizza < ApplicationRecord
  belongs_to :order
  belongs_to :pizza
  belongs_to :size
  has_many :order_toppings

  after_save :update_price

  def update_price
    update_column(:price, PizzaPriceCalculator.new(pizza, size, toppings).call)
  end

  def toppings
    order_toppings.where(add: true).map(&:topping)
  end
end

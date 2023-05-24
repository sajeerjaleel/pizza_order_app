# frozen_string_literal: true

class PizzaPriceCalculator
  attr_reader :pizza, :multiplier, :toppings

  def initialize(pizza, size, toppings)
    @pizza = pizza
    @multiplier = size.multiplier
    @toppings = toppings
  end

  def call
    multiplier * (base_price + topping_prices)
  end

  delegate :base_price, to: :pizza

  def topping_prices
    toppings.sum(&:price)
  end
end

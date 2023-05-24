# frozen_string_literal: true

require 'test_helper'
class PizzaPriceCalculatorTest < ActiveSupport::TestCase
  fixtures :pizzas, :sizes, :toppings

  test 'calculates the correct price for a pizza with toppings' do
    pizza = pizzas(:salami)
    size = sizes(:small)
    toppings = [
      toppings(:pepperoni),
      toppings(:mushrooms)
    ]

    calculator = PizzaPriceCalculator.new(pizza, size, toppings)

    assert_equal 11.5, calculator.call
  end
end

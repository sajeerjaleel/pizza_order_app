# frozen_string_literal: true

require 'test_helper'

class OrderPizzaTest < ActiveSupport::TestCase
  def setup
    @order_pizza = order_pizzas(:one)
  end

  test 'should be valid' do
    assert @order_pizza.valid?
  end

  test 'should update price after save' do
    old_price = @order_pizza.price
    @order_pizza.update(size: sizes(:medium))
    new_price = @order_pizza.reload.price
    assert_not_equal old_price, new_price
  end

  test 'should return toppings with add true' do
    assert_equal @order_pizza.toppings.count, 1
    assert_equal @order_pizza.toppings.first.name, 'Pepperoni'
  end
end

# frozen_string_literal: true

require 'test_helper'

class OrderToppingTest < ActiveSupport::TestCase
  def setup
    order = Order.create
    @order_pizza = order.order_pizzas.create(pizza: pizzas(:salami), size: sizes(:small))
    @order_pizza.update_price
    @initial_price = @order_pizza.reload.price
    @topping = toppings(:pepperoni)
    @order_topping = @order_pizza.order_toppings.create(topping: @topping, add: true)
  end

  test 'should be valid' do
    assert @order_topping.valid?
  end

  test 'should belong to an order_pizza' do
    @order_topping.order_pizza = nil
    assert_not @order_topping.valid?
  end

  test 'should belong to a topping' do
    @order_topping.topping = nil
    assert_not @order_topping.valid?
  end

  test 'should update order pizza price after save' do
    assert_equal (@order_pizza.price - @initial_price), @topping.price
  end
end

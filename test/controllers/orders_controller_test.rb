# frozen_string_literal: true

require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index with only open orders' do
    open_order = orders(:open_order)
    complete_order = orders(:complete_order)

    get orders_url

    assert_response :success

    # Check that the response includes the ID of the open and complete orders
    assert response.body.include?(open_order.id.to_s)
    assert_not response.body.include?(complete_order.id.to_s)

    # Check that the response includes the pizza name and size for each order
    open_order.order_pizzas.each do |order_pizza|
      assert response.body.include?(order_pizza.pizza.name)
      assert response.body.include?(order_pizza.size.name)
    end

    complete_order.order_pizzas.each do |order_pizza|
      assert response.body.include?(order_pizza.pizza.name)
      assert response.body.include?(order_pizza.size.name)
    end
  end

  test 'should complete the order' do
    order = Order.create(state: 0)

    patch order_url(order)

    assert_redirected_to orders_path
    assert_equal 'Order completed successfully.', flash[:notice]
    assert_equal Order.states[:complete], order.reload.state
  end
end

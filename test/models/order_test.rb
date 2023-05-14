# frozen_string_literal: true

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    # Create a promotion for salami small size pizzas
    @promotion = Promotion.create(name: 'Salami Promotion', from: 2, to: 1, target_id: pizzas(:salami).id,
                                  target_size_id: sizes(:small).id)

    # Create an order with salami and tonno pizzas
    @order = Order.create
    order_pizza1 = @order.order_pizzas.create
    order_pizza1.pizza = pizzas(:tonno)
    order_pizza1.size = sizes(:medium)
    order_pizza1.save

    order_pizza2 = @order.order_pizzas.create
    order_pizza2.pizza = pizzas(:salami)
    order_pizza2.size = sizes(:small)
    order_pizza2.save

    order_pizza3 = @order.order_pizzas.create
    order_pizza3.pizza = pizzas(:salami)
    order_pizza3.size = sizes(:small)
    order_pizza3.save
  end

  test 'Order total price is updated after save' do
    @order.update_total_price

    # Calculate the expected total price
    expected_total_price = OrderPriceCalculator.new(@order).call

    # Check that the total price is updated correctly
    assert_equal expected_total_price, @order.total_price
    # Check that the promotion was added to the order
    assert_includes @order.promotions, @promotion
  end

  test 'promotions are added to the order based on order pizzas' do
    # Add promotions
    @order.add_promotions

    # Check that the promotion was added to the order
    assert_includes @order.promotions, @promotion
  end

  test 'Promotion count in an order' do
    # Check that the promotion count is returned correctly
    assert_equal @order.promotion_count(@promotion), 2
  end
end

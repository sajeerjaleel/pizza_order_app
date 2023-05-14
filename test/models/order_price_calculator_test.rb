# frozen_string_literal: true

require 'test_helper'
class OrderPriceCalculatorTest < ActiveSupport::TestCase
  def setup
    # Create a promotion for salami small size pizzas
    @promotion = Promotion.create(name: 'Salami Promotion', from: 2, to: 1, target_id: pizzas(:salami).id,
                                  target_size_id: sizes(:small).id)

    # Create a discount for the order
    @discount = Discount.create(discount_percentage: 10)

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

  test 'calculates total price without promotions or discounts' do
    calculator = OrderPriceCalculator.new(@order)

    assert_equal 38, calculator.call
  end

  test 'calculates total price with promotion' do
    @order.promotions << @promotion
    calculator = OrderPriceCalculator.new(@order)

    assert_equal 28, calculator.call
  end

  test 'calculates total price with promotion and discount' do
    @order.promotions << @promotion
    @order.update(discount: @discount)
    calculator = OrderPriceCalculator.new(@order)

    assert_equal 25.2, calculator.call
  end
end

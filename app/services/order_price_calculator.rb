# frozen_string_literal: true

class OrderPriceCalculator
  attr_reader :order, :promotions, :discount

  def initialize(order)
    @order = order
    @promotions = order.promotions
    @discount = order.discount
  end

  def call
    total_price = 0
    order.order_pizzas.each do |order_pizza|
      total_price += order_pizza.price
    end

    promotions.each do |promotion|
      pizza_price_array = order.order_pizzas.where(pizza_id: promotion.target_id,
                                                   size_id: promotion.target_size_id).order(:price).collect(&:price)
      order_count = order.order_pizzas.where(pizza_id: promotion.target_id, size_id: promotion.target_size_id).count
      total_price = PromotionPriceCalculator.new(total_price, pizza_price_array, order_count, promotion.from,
                                                 promotion.to).call
    end

    total_price -= total_price * discount.discount_percentage / 100 if discount

    total_price
  end
end

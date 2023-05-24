# frozen_string_literal: true

class PromotionPriceCalculator
  attr_reader :pizza_price_array, :order_count, :from, :to

  def initialize(total_price, pizza_price_array, order_count, from, to)
    @total_price = total_price
    @pizza_price_array = pizza_price_array
    @order_count = order_count
    @from = from
    @to = to
  end

  def call
    promotion_count = order_count / from
    # find price to deduct - Deduct the low cost pizzas in the promotion
    deduction_price = pizza_price_array.take(from * promotion_count).sum
    # find price to add - Add the high cost pizzas in the promotion
    addition_price = pizza_price_array.last(to * promotion_count).sum
    @total_price = @total_price - deduction_price + addition_price
  end
end

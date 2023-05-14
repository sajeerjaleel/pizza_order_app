# frozen_string_literal: true

class Order < ApplicationRecord
  enum :states, %i[open complete]

  has_many :order_pizzas, dependent: :destroy
  has_many :pizzas, through: :order_pizzas
  has_and_belongs_to_many :promotions
  belongs_to :discount, optional: true

  scope :open, -> { where(state: Order.states[:open]) }

  scope :with_total_price, -> { where.not(total_price: nil) }

  def add_promotions
    eligible_promotions = Promotion.where(target_id: pizzas.pluck(:id),
                                          target_size_id: order_pizzas.pluck(:size_id)).select do |promotion|
      (promotion_count(promotion) % promotion.from).zero?
    end

    promotions << eligible_promotions
  end

  def promotion_count(promotion)
    order_pizzas.where(size_id: promotion.target_size_id, pizza_id: promotion.target_id).count
  end

  def update_total_price
    add_promotions
    update_column(:total_price, OrderPriceCalculator.new(self).call)
  end
end

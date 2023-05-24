# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :update_order_total, only: :index
  before_action :find_order, only: :update

  def index
    @orders = Order.open.includes(:pizzas, order_pizzas: [:size])
  end

  def update
    @order.update(state: Order.states[:complete])
    redirect_to orders_path, notice: 'Order completed successfully.'
  end

  private

  def update_order_total
    Order.open.with_total_price.find_each(&:update_total_price)
  end

  def find_order
    @order = Order.find(params[:id])
  end
end

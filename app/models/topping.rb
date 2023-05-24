# frozen_string_literal: true

class Topping < ApplicationRecord
  has_and_belongs_to_many :order_pizzas
end

# frozen_string_literal: true

class Size < ApplicationRecord
  has_many :order_pizzas
end

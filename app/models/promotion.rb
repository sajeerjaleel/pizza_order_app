# frozen_string_literal: true

class Promotion < ApplicationRecord
  has_and_belongs_to_many :orders
  has_one :target, foreign_key: 'target_id', class_name: 'Pizza'
  has_one :target_size, foreign_key: 'target_size_id', class_name: 'Size'
end

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# create pizza sizes
size_small = Size.create!(name: 'Small', multiplier: 0.7)
size_medium = Size.create!(name: 'Medium', multiplier: 1.0)
size_large = Size.create!(name: 'Large', multiplier: 1.3)

# create pizza toppings
topping_onions = Topping.create!(name: 'Onions', price: 1.0)
topping_cheese = Topping.create!(name: 'Cheese', price: 2.0)
topping_olives = Topping.create!(name: 'Olives', price: 2.5)

# create some pizzas
pizza_tonno = Pizza.create!(name: 'Tonno', base_price: 8.0)
pizza_margherita = Pizza.create!(name: 'Margherita', base_price: 5.0)
pizza_salami = Pizza.create!(name: 'Salami', base_price: 6.0)

# create promotion
promotion = Promotion.create!(name: 'Two for One', code: '2FOR1', target_id: pizza_salami.id,
                              target_size_id: size_small.id, from: 2, to: 1, start_date: Time.zone.now, end_date: Time.zone.now + 1.year)

# create discount
discount = Discount.create!(name: 'Save 5 percentage', code: 'SAVE5', discount_percentage: 5, start_date: Time.zone.now,
                            end_date: Time.zone.now + 1.year)

Rails.logger.debug "Total Toppings created : #{Topping.all.count}"
Rails.logger.debug "Total Sizes created : #{Size.all.count}"
Rails.logger.debug "Total Pizzas created : #{Pizza.all.count}"
Rails.logger.debug "Total Promotions created : #{Promotion.all.count}"
Rails.logger.debug "Total Discounts created : #{Discount.all.count}"

# create some orders
orders = [
  {
    id: '316c6832-e038-4599-bc32-2b0bf1b9f1c1',
    state: 'OPEN',
    created_at: '2021-04-14T11:16:00Z',
    items: [
      { pizza: pizza_tonno, size: size_large, add_toppings: [], remove_toppings: [] }
    ],
    promotion_codes: [],
    discount_code: nil
  },
  {
    id: 'f40d59d0-48bd-409a-ac7b-54a1b47f6680',
    state: 'OPEN',
    created_at: '2021-04-14T13:17:25Z',
    items: [
      { pizza: pizza_margherita, size: size_large, add_toppings: [topping_cheese, topping_onions, topping_olives],
        remove_toppings: [] },
      { pizza: pizza_tonno, size: size_medium, add_toppings: [], remove_toppings: [topping_onions, topping_olives] },
      { pizza: pizza_margherita, size: size_small, add_toppings: [], remove_toppings: [] }
    ],
    promotion_codes: [],
    discount_code: nil
  },
  {
    id: '9232679d-e3fd-40bd-81f4-7114ea96e420',
    state: 'OPEN',
    created_at: '2021-04-14T14:08:47Z',
    items: [
      { pizza: pizza_salami, size: size_medium, add_toppings: [topping_onions], remove_toppings: [topping_cheese] },
      { pizza: pizza_salami, size: size_small, add_toppings: [], remove_toppings: [] },
      { pizza: pizza_salami, size: size_small, add_toppings: [], remove_toppings: [] },
      { pizza: pizza_salami, size: size_small, add_toppings: [], remove_toppings: [] },
      { pizza: pizza_salami, size: size_small, add_toppings: [topping_olives], remove_toppings: [] }
    ],
    promotion_codes: [promotion],
    discount_code: discount.id
  }
]

# create orders and order items from the JSON data
orders.each do |order_data|
  order = Order.create!(id: order_data[:id], state: Order.states[order_data[:state].downcase],
                        created_at: order_data[:created_at], discount_id: order_data[:discount_code])

  # Add order items and toppings
  order_data[:items].each do |item|
    order_pizza = OrderPizza.create!(order_id: order.id, pizza_id: item[:pizza].id, size_id: item[:size].id)

    item[:add_toppings].each do |topping|
      OrderTopping.create!(order_pizza_id: order_pizza.id, topping_id: topping.id, add: true)
    end

    item[:remove_toppings].each do |topping|
      OrderTopping.create!(order_pizza_id: order_pizza.id, topping_id: topping.id, remove: true)
    end
  end

  # #Add promotions
  order.add_promotions
  order.reload
  order.update_total_price
end

Rails.logger.debug "Total orders created : #{Order.all.count}"

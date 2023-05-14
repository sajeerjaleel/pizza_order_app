# frozen_string_literal: true

module OrdersHelper
  def order_created_at(order)
    order.created_at.strftime('%B %e, %Y %l:%M')
  end

  def order_promotion_codes(order)
    order.promotions.pluck(:code).join(', ')
  end

  def order_discount_code(order)
    order.discount.present? ? order.discount.code : ''
  end

  def order_total_price(order)
    number_to_currency(order.total_price, unit: '€')
  end

  def order_pizza_name(order_pizza)
    "#{order_pizza.pizza.name} (#{order_pizza.size.name})"
  end

  def order_toppings(order_pizza)
    toppings = ''
    add_toppings = order_pizza.order_toppings.includes(:topping).where(add: true)
    remove_toppings = order_pizza.order_toppings.includes(:topping).where(remove: true)
    if add_toppings.present?
      toppings += "<ul>
							      <li>Add: #{add_toppings.collect { |a| a.topping.name }.join(', ')}</li>
							    </ul>"
    end

    if remove_toppings.present?
      toppings += "<ul>
							      <li>Remove: #{remove_toppings.collect { |a| a.topping.name }.join(', ')}</li>
							    </ul>"
    end
    toppings.html_safe
  end
end

module Baldrick::Listeners
  module OrderFilter
    def select_new_orders_from all_orders
      new_orders = all_orders.reject do |order|
        who = order[:who]
        previous_order = @last_orders[who]
        @last_orders[who] = order
        !previous_order.nil? and previous_order == order 
      end
      new_orders
    end
  end
end
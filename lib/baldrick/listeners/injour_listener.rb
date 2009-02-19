module Baldrick::Listeners
  class InjourListener

    def initialize options = {}
      @last_orders = {}
    end

    def orders
      order_pattern = /=== (.*?) on (.*?) ===\n\* \[(.*?)\] (.*?)\n/m
      all_orders = `injour ls`.scan(order_pattern).collect do |match|
        {
          :who => match[0],
          :where => match[1],
          :when => Time.parse(match[2]),
          :what => match[3]
        }
      end

      select_new_orders_from all_orders
    end
    
    private
    
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
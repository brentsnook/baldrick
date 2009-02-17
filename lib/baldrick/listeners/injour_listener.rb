module Baldrick::Listeners
  class InjourListener
    include Baldrick::Listeners::OrderFilter

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
  end
end
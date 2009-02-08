require 'set'

module Baldrick
  class InjourListener

    def initialize options
      @previous_orders = []
    end

    def orders
      order_pattern = /=== (.*?) on (.*?) ===\n\* \[(.*?)\] (.*?)\n/m
      all_orders = `injour ls`.scan(order_pattern).collect do |match|
        {
          :who => match[0],
          :where => match[1],
          :when => match[2],
          :what => match[3]
        }
      end

      new_orders = all_orders.reject {|order| @previous_orders.member? order}
      @previous_orders += new_orders
      new_orders
    end
  end
end
require 'open-uri'

module Baldrick::Listeners
  class FeedListener

    def initialize options
      @url = options[:at]
      # just don't go trying to consume feeds before 1970
      @time_of_last_order = Time.at 0
    end

    def orders
      content = open(@url){|f| f.read}
      select_new_orders_from FeedOrders.within(content)
    end 
    
    private
    
    def select_new_orders_from orders
      new_orders = orders.select {|order| order[:when] and order[:when] > @time_of_last_order}
      @time_of_last_order = new_orders.collect {|order| order[:when]}.sort.last || @time_of_last_order
      new_orders
    end   
  end 
end
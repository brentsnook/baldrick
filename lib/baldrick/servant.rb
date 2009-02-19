module Baldrick

  class Servant
    
    def initialize
      @tasks, @listeners = [], []
    end
     
    def add_task task
      @tasks << task
    end

    def add_listener listener
      @listeners << listener
    end

    def serve
      orders.each {|order| follow order}
    end

    def follow order
      @tasks.each{|task| task.run order}
    end

    private

    def orders
      @listeners.inject([]) do |all_orders, listener|
        begin
          all_orders + listener.orders
        rescue Exception => exception
          puts exception 
          all_orders  
        end
      end
    end

  end

end
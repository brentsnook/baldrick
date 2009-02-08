module Baldrick

  class Servant

    include Configuration

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
      @listeners.inject([]) {|all_orders, listener| all_orders + listener.orders}
    end

  end

end
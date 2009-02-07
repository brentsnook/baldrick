module Baldrick

  class Servant

    include Configuration

    def initialize
      @jobs, @listeners = [], []
    end
     
    def add_job job
      @jobs << job
    end

    def add_listener listener
      @listeners << listener
    end

    def serve
      new_orders.each {|order| follow order}
    end

    def follow order
      @jobs.each{|job| job.run order}
    end

    private

    def new_orders
      @listeners.inject([]) {|all_orders, listener| all_orders + listener.new_orders}
    end

  end

end
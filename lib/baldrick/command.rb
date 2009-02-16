require 'singleton'

module Baldrick
  class Command 
    include Singleton
    
    def initialize
      @listener_classes = {:injour => Listeners::InjourListener}
      @servant = Servant.new
      @wait_period = 2  
    end
      
    def execute(stdout)
      stdout << "Servant started...\n"; stdout.flush   
      while should_serve? do
        @servant.serve
        sleep @wait_period
      end
    end

    def should_serve?
      true
    end 
    
    def listen_every period
      @wait_period = period
    end  
    
    def listen_to listener_type, options={}
      listener_class = listener_class_for(listener_type) || raise("No order listener implementation found for #{listener_type}")
      @servant.add_listener(listener_class.new(options))
    end
    
    def to(matcher, &procedure)
      @servant.add_task Task.new(matcher, procedure)
    end
    
    def register_listener_type type, listener_class
      @listener_classes[type] = listener_class
    end
      
    def listener_class_for type
      @listener_classes[type]
    end    

  end
end
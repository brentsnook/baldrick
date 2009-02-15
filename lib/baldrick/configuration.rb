module Baldrick

  module Configuration
    
    def self.included target_class
      target_class.extend ClassMethods  
    end    

    def listen_to listener_type, options={}
      listener_class = self.class.listener_class_for(listener_type) || raise("No order listener implementation found for #{listener_type}")
      add_listener(listener_class.new(options))
    end

    def to(matcher, &procedure)
      add_task Task.new(matcher, procedure)
    end

    module ClassMethods
      def register_listener_type type, listener_class
        listener_classes[type] = listener_class
      end
      
      def listener_class_for type
        listener_classes[type]
      end  
      
      private
      
      def listener_classes
        @listener_classes ||= {}
      end    
    end  
  end
end
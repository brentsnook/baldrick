module Baldrick
  module Configuration
    
    def listener_class_for type
      listener_classes[type]
    end

    def listen_to listener_type, options={}
      listener_class = listener_class_for(listener_type)
      raise "No order listener implementation found for #{listener_type}" unless listener_class
      add_listener(listener_class.new(options))
    end

    def register_listener_type type, listener_class
      listener_classes[type] = listener_class
    end

    def to(matcher, &procedure)
      add_task Task.new(matcher, procedure)
    end

    private

    def listener_classes
      @listener_classes ||= {}
    end

  end
end
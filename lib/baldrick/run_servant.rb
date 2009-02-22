module Baldrick
  module RunServant

    def self.included clazz
      # register shutdown hook ONLY when the module is included
      at_exit do
        raise $! if $!
        Baldrick::Command.instance.execute STDOUT
      end 
      
      trap(:INT) do
        Baldrick::Command.instance.stop!
      end     
    end  
    
    # send configuration messages to the command
    def method_missing name, *args, &block
      Baldrick::Command.instance.respond_to?(name) ? Baldrick::Command.instance.send(name, *args, &block) : super(name, args)        
    end
  
  end
end    
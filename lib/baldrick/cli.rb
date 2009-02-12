module Baldrick
  class CLI

    def self.execute(stdout, arguments=[])
      
      options = Options.from arguments, stdout
      
      servant = Servant.new

      servant.register_listener_type :injour, InjourListener 
      servant.instance_eval File.read(options[:config_file]), options[:config_file], 1

      stdout << "Servant started...\n"; stdout.flush   

      while should_serve? do
        servant.serve
        sleep options[:polling_period]
      end

    end

    def self.should_serve?
      true
    end

    def self.shut_down
      @should_serve = false
    end
  end
end
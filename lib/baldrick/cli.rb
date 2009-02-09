module Baldrick
  class CLI

    POLL_PERIOD = 2

    def self.execute(stdout, args=[])
      servant = Servant.new

      servant.register_listener_type :injour, InjourListener
      config_file = File.expand_path(args[0])
      servant.instance_eval File.read(config_file), config_file, 1

      stdout << "Servant started...\n"; stdout.flush   

      while should_serve? do
        servant.serve
        sleep POLL_PERIOD
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
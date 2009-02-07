module Baldrick
  class CLI
    def self.execute(stdout, args=[])
      servant = Servant.new
      servant.instance_eval File.read(args[0])
      while should_serve? do
        servant.serve
        sleep 5
      end
    end

    def self.should_serve?
      true
    end
  end
end
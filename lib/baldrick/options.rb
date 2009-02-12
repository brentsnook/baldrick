require 'optparse'
module Baldrick
  class Options
    def self.from arguments, stdout
      options = {
        :polling_period => 2
      }

      OptionParser.new do |opts|
        opts.separator ''
        opts.on('-p', '--poll=SECONDS', 'Listening poll period.') do |period|
          options[:polling_period] = period.to_i
        end
        opts.on('-c', '--configuration=FILE') do |path|
          options[:config_file] = File.expand_path(path)    
        end       
        opts.on("-h", "--help", "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)

        if options[:config_file].nil?
          stdout.puts opts
          exit
        end
      end

      options
    end
  end  
end
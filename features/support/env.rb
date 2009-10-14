require File.dirname(__FILE__) + '/../../lib/baldrick'

gem 'cucumber'
require 'cucumber'
gem 'rspec'
require 'spec'

Before do
  CommandOutput.clear
end

After do
  ScenarioProcess.kill_all
end


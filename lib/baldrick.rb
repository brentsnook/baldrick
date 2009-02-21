$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Baldrick
  VERSION = '0.0.1'
end

require 'baldrick/listeners/xpath_locator'
require 'baldrick/listeners/injour_listener'
require 'baldrick/listeners/feed_listener'
require 'baldrick/listeners/feed_orders'

require 'baldrick/servant'
require 'baldrick/task'

require 'baldrick/command'
require 'baldrick/action_orders'
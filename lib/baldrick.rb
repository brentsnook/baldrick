$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Baldrick
  VERSION = '0.0.1'
end

Dir.glob(File.dirname(__FILE__) + '/baldrick/**/*.rb').each {|file| require file}
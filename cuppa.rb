#cuppa.rb
require 'rubygems'
require 'baldrick_serve'

listen_to :feed, :at => 'http://search.twitter.com/search.atom?q=cup+of'

on_hearing /cup of (.*?)[\.,]/ do |beverage, order|
  puts "#{order[:who]} would like a cup of #{beverage}"
end

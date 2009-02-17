require 'open-uri'
require 'rss'

module Baldrick::Listeners
  class RSSListener
    include Baldrick::Listeners::OrderFilter

    def initialize options
      @last_orders = {}
      @url = options[:at]
    end
    
    def orders
      content = open(@url){|f| f.read}
      rss = RSS::Parser.parse(content, false)
      all_orders = rss.items.collect do |item|
        {
          :who => rss.channel.title,
          :what => item.to_s,
          :when => item.pubDate,
          :where => item.link
        } 
      end
      
      select_new_orders_from all_orders 
    end  
  end  
end
module Baldrick::Listeners

  class FeedOrders
    
    def self.within xml
      XPathLocator.from_xml(xml).find_nodes_matching('//item', '//entry').collect {|item| order_from item} 
    end
    
    private
    
    def self.order_from item
      locator = XPathLocator.from_node item
      publish_time = locator.find_text_matching 'published/text()', 'pubDate/text()', 'date/text()', 'updated/text()'
      {
        :what => item.to_s,
        :who => locator.find_text_matching('author/name/text()', 'author/text()'), 
        :when => publish_time ? Time.parse(publish_time) : nil,
        :where => locator.find_text_matching('link/text()', "link[@rel='alternate']/@href")
      }
    end 
  
  end
end
module Baldrick::Listeners
  class FeedOrders
    
    def self.within xml
      
      doc = Nokogiri::XML xml
      
      matches = ['//item', '//entry'].collect do |path|
        doc.xpath path
      end
      matches.flatten.collect {|item| order_from item} 
    end
    
    private
    
    def self.order_from item
      {
        :what => item.to_s,
        :who => find_any_match(item, ['author/name/text()', 'author/text()']), 
        :when => publish_time_of(item),
        :where => find_any_match(item, ['link/text()', "link[@rel='alternate']/@href"])
      }
    end 
    
    def self.find_any_match content, paths   
      match = nil 
      paths.each do |path|
        match ||= content.xpath(path).first
      end
      match ? match.text : nil      
    end   

    def self.publish_time_of item
      match = find_any_match item, ['published/text()', 'pubDate/text()', 'date/text()', 'updated/text()']
      Time.parse match if match     
    end   
  end
end
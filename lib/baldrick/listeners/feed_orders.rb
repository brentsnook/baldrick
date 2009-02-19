module Baldrick::Listeners
  class FeedOrders
    
    def self.within xml
      matches = ['item', 'entry'].collect do |tag|
        xml.scan /#{tag_pattern(tag){'.*?'}}/m
      end
      matches.flatten.collect {|item| order_from item} 
    end
    
    private
    
    def self.order_from item
      {
        :what => item,
        :who => author_of(item),
        :when => publish_time_of(item),
        :where => location_of(item)
      }
    end 
    
    def self.tag_content name
      "\\w*:?#{name}[^>]*"
    end  
    
    def self.tag_pattern name
      "<#{tag_content name}>\\s*#{yield}\\s*<\/#{tag_content name}>"
    end   
    
    def self.find_any_match content, patterns
      match = nil
            
      patterns.each do |pattern|
        match ||= content.scan(/#{pattern}/m).flatten.first
      end
      
      match      
    end   
     
    def self.author_of item
      patterns = [
        tag_pattern('author') {tag_pattern('name') {'(.*?)'}},
        tag_pattern('author') {'(.*?)'},
        tag_pattern('creator') {'(.*?)'}
      ] 
      
      find_any_match item, patterns 
    end
    
    def self.publish_time_of item
      patterns = [ 
        tag_pattern('published') {'(.*?)'},
        tag_pattern('pubDate') {'(.*?)'},
        tag_pattern('date') {'(.*?)'},
        tag_pattern('updated') {'(.*?)'},
      ] 
      
      match = find_any_match item, patterns
      Time.parse match if match     
    end 
    
    def self.location_of item
      patterns = [ 
        tag_pattern('link') {'(.*?)'},
        "<#{tag_content 'link.*href="(.*?)"'}/>"
      ] 
      
      find_any_match item, patterns    
    end     
  end
end
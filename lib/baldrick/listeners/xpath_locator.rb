require 'nokogiri'

module Baldrick::Listeners
  
  class XPathLocator
    
    def self.from_xml xml
      from_node(Nokogiri::XML xml)
    end  
    
    def self.from_node node
      new node
    end
    
    def initialize node
      @doc = node     
    end  
    
    def find_text_matching *paths
      matches = find_nodes_matching(*paths)
      matches.first.text if !matches.empty?
    end  
    
    def find_nodes_matching *paths   
      paths.inject([]) do |last_match, path|
        last_match.empty? ? @doc.xpath(path) : last_match
      end     
    end
  end
end
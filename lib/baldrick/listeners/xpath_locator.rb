require 'nokogiri'

module Baldrick::Listeners
  
  class XPathLocator
    
    def self.from_xml xml
      
      from_node Nokogiri::XML(strip_default_namespaces_from xml)
    end  
    
    def self.from_node node
      self.new node
    end
    
    def initialize node
      @doc = node     
    end  
    
    def find_text_matching *paths
      matches = find_nodes_matching *paths
      matches.first.text unless matches.empty?
    end  
    
    def find_nodes_matching *paths  
      @doc.search *paths || []
    end
    
    private
    
    # need to do this so that default namespaced elements can be located
    # http://nokogiri.lighthouseapp.com/projects/19607/tickets/8-nokogirixml-str-not-allow-an-xpath-result
    # has to be a better way though
    def self.strip_default_namespaces_from xml
      xml.gsub /xmlns="[^"]*"/, ''    
    end  
  end
end
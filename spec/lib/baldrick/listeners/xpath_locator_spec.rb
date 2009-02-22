require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

include Baldrick::Listeners

describe XPathLocator do

  describe 'when created' do
 
    it 'should allow a new locator to be created from an XML string' do
      locator = XPathLocator.from_xml '<root><child/></root>'
    
      locator.find_nodes_matching('//child').should_not be_empty
    end  
    
    it 'should allow a new locator to be created from a previously returned node' do
      node = XPathLocator.from_xml('<root><child><grandchild/></child></root>').find_nodes_matching('//child').first
      locator = XPathLocator.from_node node 
    
      locator.find_nodes_matching('//grandchild').should_not be_empty  
    end 
  end
  
  describe 'when finding nodes' do
  
    it 'should find all nodes matching any of the given xpath expressions' do
      locator = XPathLocator.from_xml '<root><match/></root>'
      
      locator.find_nodes_matching('//nomatches', '//match').size.should == 1    
    end  
  
    it 'should handle tags with a default namespace' do
      locator = XPathLocator.from_xml '<root xmlns="http://namespace.com"><match/></root>'
      
      locator.find_nodes_matching('//match').size.should == 1      
    end  
    
    it 'should find only the first text matching any of the given xpath expressions' do
      locator = XPathLocator.from_xml '<root><match>first</match><match>second</match></root>'
      
      locator.find_text_matching('//match').should == 'first'      
    end
  end
end  
require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

include Baldrick::Listeners

describe FeedOrders do
  
  before :each do
    @item_locator = mock('item locator')
    XPathLocator.stub!(:from_xml).and_return @item_locator
  end
  
  it 'first searches items then elements for orders' do
    @item_locator.should_receive(:find_nodes_matching).with('//item', '//entry').and_return []
    
    FeedOrders.within ''
  end
  
  it 'creates an order for every item found' do
    node = stub 'node', :null_object => true
    @item_locator.stub!(:find_nodes_matching).and_return [node, node, node]
    
    FeedOrders.within('').size.should == 3
  end   
  
  describe 'when creating an order' do
  
    before :each do
      @node = stub 'node', :null_object => true
      @item_locator.stub!(:find_nodes_matching).and_return [@node]
      @text_locator = stub('item locator', :null_object => true)
      XPathLocator.stub!(:from_node).and_return @text_locator
      
      @time = Time.now
      Time.stub!(:parse).and_return @time
    end
      
    it "parses the publish time and use it as 'when'" do
      Time.stub!(:parse).with(@time.to_s).and_return @time
      @text_locator.stub!(:find_text_matching).with('published/text()', 'pubDate/text()', 'date/text()', 'updated/text()').and_return @time.to_s
      
      FeedOrders.within('').first[:when].should == @time  
    end  
    
    it "uses the contents of the item as 'what'" do
      @text_locator.stub!(:find_text_matching).and_return stub('text', :null_object => true)
      @node.stub!(:to_s).and_return 'item node contents'
             
      FeedOrders.within('').first[:what].should == 'item node contents'
    end
    
    it "uses the author as the 'who'" do
      @text_locator.stub!(:find_text_matching).with('author/name/text()', 'author/text()').and_return 'Alan Moore'
             
      FeedOrders.within('').first[:who].should == 'Alan Moore'     
    end  
    
    it "uses the link as the 'where'" do
      @text_locator.stub!(:find_text_matching).with('link/text()', "link[@rel='alternate']/@href").and_return 'http://internet.com'
             
      FeedOrders.within('').first[:where].should == 'http://internet.com'      
    end  
  end
end
require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

include Baldrick::Listeners

describe FeedOrders do

  it "should use the entire item as the value of 'what'" do
    content = '<feed><item>bad replicant</item></feed>'
    FeedOrders.within(content).first[:what].should == '<item>bad replicant</item>'
  end
  
  describe 'when identifying an order' do
    it 'should recognise an item' do
      FeedOrders.within('<feed><item> </item><item> </item></feed>').size.should == 2        
    end  
  
    it 'should recognise an entry' do
      FeedOrders.within('<feed><entry> </entry><entry> </entry></feed>').size.should == 2
    end
    
    it 'should not recognise any other tag' do
      FeedOrders.within('<feed><entry> </entry><entry> </entry></feed>').size.should == 2   
    end
    
    it 'should not care if the order tag has attributes' do
      FeedOrders.within('<feed><item atribute="thingo"> </item></feed>').size.should == 1       
    end
    
    it 'should not care if the order tag has a namespace' do
      FeedOrders.within('<feed><blah:item> </blah:item></feed>').size.should == 1
    end    
  end
  
  describe "when identifying 'who'" do

    it 'should check for author name' do
      FeedOrders.within(<<-FEED
<feed>
  <item>
    <author>
      <name>George Orwell</name>
    </author>
  </item>
</feed>
FEED
      ).first[:who].should == 'George Orwell'
    end
    
    it 'should check for author' do
      FeedOrders.within(<<-FEED
<feed>
  <item>
    <author>Chuck Palahniuk</author>
  </item>
</feed>
FEED
      ).first[:who].should == 'Chuck Palahniuk'
    end

    it 'should check for creator' do
      FeedOrders.within(<<-FEED
<feed>
  <item>
    <creator>Alan Moore</creator>
  </item>
</feed>
FEED
      ).first[:who].should == 'Alan Moore'
    end
  end 
  
  describe "when identifying 'when'" do
    
    ['published', 'updated', 'date', 'pubDate'].each do |date_tag|
      it "should check #{date_tag}" do
        FeedOrders.within(<<-FEED
<feed>
  <item>
    <#{date_tag}>Fri Feb 20 00:07:48 +1100 2009</#{date_tag}>
  </item>
</feed>
FEED
        ).first[:when].should == Time.parse('Fri Feb 20 00:07:48 +1100 2009')
      end
    end 
    
  end 
  
  describe "when identifying 'where'" do

    it 'should check link contents' do
      FeedOrders.within(<<-FEED
<feed>
  <item>
    <link>http://thing</link>
  </item>
</feed>
FEED
      ).first[:where].should == 'http://thing'
    end
    
    it 'should check link href attribute' do
      FeedOrders.within(<<-FEED
<feed>
  <item>
    <link href="http://thing" />
  </item>
</feed>
FEED
      ).first[:where].should == 'http://thing'
    end
  end
end  

  # it "should attempt to obtain the 'where' from a variety of locations"
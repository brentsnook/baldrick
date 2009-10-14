require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

include Baldrick::Listeners

describe FeedListener do

  before(:each) do
    @listener = FeedListener.new :at => ''
  end

  it 'allows RSS URL to be specified' do
    @listener = FeedListener.new :at => 'http://billywitchdoctor.com/rss' 
    FeedOrders.stub!(:within).and_return []
    
    @listener.should_receive(:open).with 'http://billywitchdoctor.com/rss'
  
    @listener.orders  
  end  
  
  it 'only return orders newer than that last stored' do
    
    now = Time.now
    old_news = {:what => 'shake has gone...', :when => now}
    new_news = {:what => 'newsflash! the drizzle is coming', :when => now + 1}
    stale_news = {:what => 'carl is incredibly lonely', :when => now - 1}
    latest_news = {:what => 'the drizzle is the shizzle!', :when => now + 2}

    @listener.stub! :open
    FeedOrders.stub!(:within).and_return [old_news], [old_news, new_news, stale_news, latest_news]

    @listener.orders
    
    @listener.orders.should == [new_news, latest_news]    
  end
  
  it "handles orders with no 'when' specified" do
    @listener.stub! :open
    FeedOrders.stub!(:within).and_return  [{:what => 'shake has gone...', :when => nil}]

    @listener.orders 
  end  
   
end  
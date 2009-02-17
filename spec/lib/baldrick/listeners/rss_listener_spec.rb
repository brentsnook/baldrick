require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

include Baldrick::Listeners

describe RSSListener do

  before(:each) do
    @rss_url = 'http://billywitchdoctor.com/rss'
    @listener = RSSListener.new(:at => @rss_url)
  end

  it "should interpret the title of the channel as 'who'" do
    @listener.stub!(:open).and_return rss(:channel_title => "master shake's plan for world domination")
    @listener.orders.first[:who].should == "master shake's plan for world domination"
  end  

  it "should use the entire item as 'what'" do
    @listener.stub!(:open).and_return rss(:item_1_title => 'bad replicant')
    @listener.orders.first[:what].should match(/<item>.*<title>bad replicant<\/title>.*<\/item>/m)    
  end  

  it "should interpret the parsed item publish date as 'when'" do
    @listener.stub!(:open).and_return rss(:item_1_pubDate => 'Tue, 20 Apr 2000 04:00:00 GMT')
    @listener.orders.first[:when].should == Time.parse('Tue, 20 Apr 2000 04:00:00 GMT')   
  end    
    
  it "should interpret the item link as 'where'" do
    @listener.stub!(:open).and_return rss(:item_1_link => 'http://carlwash.com')
    @listener.orders.first[:where].should == 'http://carlwash.com'  
  end  
  
  it 'should allow RSS URL to be specified' do
    @listener.should_receive(:open).with(@rss_url).and_return rss
    @listener.orders  
  end  
  
  it 'should only return new orders for a channel' do
    @listener.stub!(:open).and_return rss(:channel_title => 'channel', :item_1_title => 'some item'), rss(:channel_title => 'channel', :item_1_title => 'some item')
    @listener.orders
    
    @listener.orders.should be_empty   
  end 
  
  def rss fields={}
    <<-RSS
<?xml version="1.0"?>
<rss version="2.0">
  <channel>
    <title>#{fields[:channel_title]}</title>
    <link></link>
    <description></description>
    <language></language>
    <pubDate></pubDate>
    <lastBuildDate></lastBuildDate>
    <docs></docs>
    <generator></generator>
    <managingEditor></managingEditor>
    <webMaster></webMaster>
    <ttl></ttl>

    <item>
      <title>#{fields[:item_1_title]}</title>
      <link>#{fields[:item_1_link]}</link>
      <description></description>
      <pubDate>#{fields[:item_1_pubDate]}</pubDate>
      <guid></guid>
    </item>
  </channel>
</rss>
RSS
  end  
end  
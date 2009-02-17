require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

include Baldrick::Listeners

describe InjourListener do

  before(:each) do
    @listener = InjourListener.new
    Time.stub!(:parse)
  end

  it 'should only return new orders' do

    first_status = <<-FIRST_STATUS
=== nathan on dk3.mordhaus.net:43215 ===
* [05-Feb-2009 11:30 PM] i like chips
FIRST_STATUS
    second_status = <<-SECOND_STATUS
=== nathan on dk3.mordhaus.net:43215 ===
* [05-Feb-2009 11:30 PM] i like chips
=== murderface on dk4.mordhaus.net:43215 ===
* [05-Feb-2009 11:31 PM] no kidding
SECOND_STATUS

    @listener.stub!(:`).with('injour ls').and_return first_status, second_status

    @listener.orders

    @listener.orders.should == [
      {
        :who => 'murderface',
        :what => 'no kidding',
        :where => 'dk4.mordhaus.net:43215',
        :when => nil
      }]
  end
  
  it 'should handle multiple orders from a single user' do

    status = <<-STATUS
=== skwisgaar on dk5.mordhaus.net:43215 ===
* [05-Feb-2009 11:30 PM] stops copies me!
=== skwisgaar on dk5.mordhaus.net:43215 ===
* [05-Feb-2009 11:31 PM] I means its, stops copies me!
=== skwisgaar on dk5.mordhaus.net:43215 ===
* [05-Feb-2009 11:32 PM] STOPS COPIES ME!
STATUS

    @listener.stub!(:`).with('injour ls').and_return status

    @listener.orders.collect{|order| order[:what]}.should == ['stops copies me!', 'I means its, stops copies me!', 'STOPS COPIES ME!']
  end 
  
  describe 'reading individual parts of an order' do
    
    before :each do
      status = <<-STATUS
=== twinkletits on dk6.mordhaus.net:43215 ===
* [05-Feb-2009 11:30 PM] who wants a banana sticker?
STATUS
      @listener.stub!(:`).with('injour ls').and_return status

      @order = @listener.orders.first
    end
    
    it "should interpret injour user as 'who'" do
      @order[:who].should == 'twinkletits'
    end 

    it "should interpret status as 'what'" do
      @order[:what].should == 'who wants a banana sticker?'
    end

    it "should interpret injour address as 'where'" do
      @order[:where].should == 'dk6.mordhaus.net:43215'
    end
       
    it "should interpret parsed time as 'when'" do
      @order[:when].should == Time.parse('05-Feb-2009 11:30 PM')
    end
  end
end
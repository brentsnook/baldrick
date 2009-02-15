require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

include Baldrick::Listeners

describe InjourListener do

  before(:each) do
    @listener = InjourListener.new
  end

  it 'should correctly identify who, what, when and where for one or more statuses' do
    @listener.stub!(:`).with('injour ls').and_return <<-STATUS
=== toki on dk1.mordhaus.net:43215 ===
* [05-Feb-2009 11:40 PM] fooood... libraries...
=== pickles on dk2.mordhaus.net:43215 ===
* [05-Feb-2009 11:55 PM] @toki dood, its called a grocery store
STATUS

    @listener.orders.should == [
      {
        :who => 'toki',
        :what => 'fooood... libraries...',
        :where => 'dk1.mordhaus.net:43215',
        :when => '05-Feb-2009 11:40 PM'
      },
      {
        :who => 'pickles',
        :what => '@toki dood, its called a grocery store',
        :where => 'dk2.mordhaus.net:43215',
        :when => '05-Feb-2009 11:55 PM'
      }
    ]
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
        :when => '05-Feb-2009 11:31 PM'
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

    @listener.orders.should == [
      {
        :who => 'skwisgaar',
        :what => 'stops copies me!',
        :where => 'dk5.mordhaus.net:43215',
        :when => '05-Feb-2009 11:30 PM'
      },
      {
        :who => 'skwisgaar',
        :what => 'I means its, stops copies me!',
        :where => 'dk5.mordhaus.net:43215',
        :when => '05-Feb-2009 11:31 PM'
      },     
      {
        :who => 'skwisgaar',
        :what => 'STOPS COPIES ME!',
        :where => 'dk5.mordhaus.net:43215',
        :when => '05-Feb-2009 11:32 PM'
      }]
  end  

end
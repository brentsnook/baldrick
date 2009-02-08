require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe InjourListener do

  before(:each) do
    @listener = InjourListener.new
  end

  describe 'when parsing injour output' do
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
        }]
    end

  end

  it 'should not return orders that have already been returned' do

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

end
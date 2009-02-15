require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

include Baldrick::Listeners

describe RSSListener do
  
  before(:each) do
    @listener = InjourListener.new
  end

  it 'should correctly identify who, what, when and where for one or more updates'
  
  it 'should allow RSS URL to be specified'
  
  it 'should only return new orders'
end  
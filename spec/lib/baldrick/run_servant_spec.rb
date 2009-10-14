require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe RunServant do
  
  describe 'when exiting' do
    it 'rethrows any exceptions thrown in the script body'
    it 'causes the command to execute'  
  end
  
  it 'delegates all calls for missing methods to the command'   
  it 'causes an interrupt to stop execution of the command'
end
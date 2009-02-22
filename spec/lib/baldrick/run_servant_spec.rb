require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe RunServant do
  
  describe 'when exiting' do
    it 'should rethrow any exceptions thrown in the script body'
    it 'should cause the command to execute'  
  end
  
  it 'should delegate all calls for missing methods to the command'   
  it 'should cause an interrupt to stop execution of the command'
end
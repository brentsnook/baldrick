require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe Task do

  it 'should run if order matches' do
    @matcher = stub('matcher', :match => [''])
    @procedure = stub('procedure', :arity => 1)

    @procedure.should_receive :call

    run ''
  end

  it 'should not run if order does not match' do
    @matcher = stub('matcher', :match => nil)
    @procedure = stub('procedure', :arity => 1)

    @procedure.should_not_receive :call

    run ''
  end

  it 'should only pass as many arguments as the procedure can handle'

  it 'should allow a procedure to maintain state'

  it 'should pass all matching portions of the command to the procedure as separate arguments'
  
  def run order
    Task.new(@matcher, @procedure).run order  
  end

end
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe Task do

  it 'should check the what value of the command when determining whether or not to run' do
    @matcher = mock('matcher')

    @matcher.should_receive(:match).with 'what value'

    run :what => 'what value'
  end

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

  it 'should only pass as many arguments as the procedure can handle' do
    @matcher = stub('matcher', :match => ['', '1', '2', '3', '4'])
    @procedure = stub('procedure', :arity => 3)

    @procedure.should_receive(:call).with('1', '2', '3')

    run ''
  end

  it 'should not pass the matched string to the procedure' do
    @matcher = stub('matcher', :match => ['matching string', '1', '2'])
    @procedure = stub('procedure', :arity => 1)

    @procedure.should_receive(:call).with('1')

    run ''
  end

  it 'should pass all matching portions of the command and the command to the procedure' do
    @matcher = stub('matcher', :match => ['', 'com', 'mand'])
    @procedure = stub('procedure', :arity => 3)

    @procedure.should_receive(:call).with('com', 'mand', 'command')

    run :what => 'command'
  end
  
  def run order
    Task.new(@matcher, @procedure).run order  
  end

end
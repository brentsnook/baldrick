describe 'a configurable object', :shared => true do

  before(:each) do
    @object = described_type.new
  end

  it 'should be told of how to listen for orders of a particular type' do
    @object.register_listener_type :type, (listener_class = mock('listener class'))

    @object.listener_class_for(:type).should == listener_class
  end

  describe 'when told where to listen for orders' do

    it 'should add a new listener of a recognised type' do
      listener_class = stub('listener class', :new => (listener = mock('listener')))
      @object.stub!(:listener_class_for).with(:recognised_type).and_return listener_class

      @object.should_receive(:add_listener).with listener

      @object.listen_to :recognised_type
    end

    it 'should configure a new listener with given options' do
      listener_class = stub 'listener class'
      @object.stub!(:listener_class_for).with(:listener_type).and_return listener_class
      @object.stub! :add_listener

      listener_class.should_receive(:new).with({:option => true})

      @object.listen_to :listener_type, :option => true
    end
  
    it 'should fail if the listener type is not recognised' do
      @object.stub!(:listener_class_for).with(:unrecognised_type).and_return nil

      lambda{@object.listen_to :unrecognised_type}.should raise_error(RuntimeError, 'No order listener implementation found for unrecognised_type')
    end
                  
  end

  describe 'when told how to perform a task' do

    it 'should create a new task from the instructions given' do

      procedure = lambda {}
      Task.stub!(:new).with(/put the kettle on/, procedure).and_return(task = stub('job'))

      @object.should_receive(:add_task).with task

      @object.to /put the kettle on/, &procedure
    end

  end

end
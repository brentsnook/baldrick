require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe Command do

  before :each do
    @servant = mock('servant', :null_object => true)
    Servant.stub!(:new).and_return @servant
    @stdout = stub('stdout', :null_object => true)
    
    # including Singleton marks new as private but I still want to instantiate it for testing
    # nasty, I know
    @command = Command.send(:new)
  end
  
  describe 'when executing' do
  
    it 'should register the injour listener type by default' do
      @command.listener_class_for(:injour).should == Listeners::InjourListener
    end
  
    it 'should display a startup message' do
      @command.stub!(:should_serve?).and_return false
    
      @stdout.should_receive(:<<).with /started/
    
      @command.execute @stdout
    end
  
    it 'should tell the servant to serve repeatedly' do
      @command.stub!(:should_serve?).and_return true, true, false
      @command.stub!(:sleep)
    
      @servant.should_receive(:serve).twice
    
      @command.execute @stdout  
    end
  
    it 'should wait for 2 seconds between service by default' do
      @command.stub!(:should_serve?).and_return true, false
  
      @command.should_receive(:sleep).with(2)
    
      @command.execute @stdout
    end
  
    it 'should allow wait period between service to be specified' do
      @command.stub!(:should_serve?).and_return true, false
      @command.listen_every 10
  
      @command.should_receive(:sleep).with(10)
    
      @command.execute @stdout
    end  
  
    it 'should allow server to be stopped with an interrupt'
  end
  
  describe 'configuration' do
    
    it 'should be told of how to listen for orders of a particular type' do
      @command.register_listener_type :type, (listener_class = mock('listener class'))
  
      @command.listener_class_for(:type).should == listener_class
    end

    describe 'when told where to listen for orders' do
    
      it 'should add a new listener of a recognised type to the servant' do
        listener_class = stub('listener class', :new => (listener = mock('listener')))
        @command.stub!(:listener_class_for).with(:recognised_type).and_return listener_class
        
        @servant.should_receive(:add_listener).with listener
    
        @command.listen_to :recognised_type
      end
          
      it 'should configure a new listener with given options' do
        listener_class = stub 'listener class'
        @command.stub!(:listener_class_for).with(:listener_type).and_return listener_class
        @servant.stub! :add_listener
          
        listener_class.should_receive(:new).with({:option => true})
          
        @command.listen_to :listener_type, :option => true
      end
          
      it 'should fail if the listener type is not recognised' do
        @command.stub!(:listener_class_for).with(:unrecognised_type).and_return nil
          
        lambda{@command.listen_to :unrecognised_type}.should raise_error(RuntimeError, 'No order listener implementation found for unrecognised_type')
      end
    
    end
    
    describe 'when told how to perform a task' do
      it 'should add a new task to the servant using the instructions given' do
        procedure = lambda {}
        Task.stub!(:new).with(/put the kettle on/, procedure).and_return(task = stub('job'))
    
        @servant.should_receive(:add_task).with task
    
        @command.to /put the kettle on/, &procedure
      end
    end
  end
end
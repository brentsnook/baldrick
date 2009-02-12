require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe CLI, "execute" do

  before(:each) do
    @servant = mock('Servant', :null_object => true)

    Options.stub!(:from).and_return :config_file => '', :polling_period => 1
    Servant.stub!(:new).and_return @servant
    
    @stdout = stub('stdout', :null_object => true)
  end

  it 'should register the injour listener type with the servant' do
    File.stub!(:read).and_return ''

    CLI.stub!(:should_serve?).and_return false

    @servant.should_receive(:register_listener_type).with :injour, InjourListener

    CLI.execute @stdout, nil
  end
  
  it 'should configure the servant with the given configuration file' do
    Options.stub!(:from).and_return :config_file => '/config/file'
    File.stub!(:read).with('/config/file').and_return 'config'
    CLI.stub!(:should_serve?).and_return false
  
    @servant.should_receive(:instance_eval).with 'config', anything, anything
  
    CLI.execute @stdout, nil
  end   
  
  it 'should use the config file path and starting line number to allow for better error messages' do
    Options.stub!(:from).and_return :config_file => '/config/file'
    File.stub!(:read)
    CLI.stub!(:should_serve?).and_return false
  
    @servant.should_receive(:instance_eval).with anything, '/config/file', 1
  
    CLI.execute @stdout, nil
  end
  
  it 'should display a startup message' do
    File.stub!(:read).and_return ''
    CLI.stub!(:should_serve?).and_return false
    
    @stdout.should_receive(:<<).with /started/
    
    CLI.execute @stdout, nil
  end
  
  it 'should allow server to be stopped with an interrupt'
end
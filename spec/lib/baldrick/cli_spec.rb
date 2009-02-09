require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe CLI, "execute" do

  before(:each) do
    @stdout = StringIO.new
    @servant = mock('Servant', :null_object => true)

    Servant.stub!(:new).and_return @servant
  end

  it 'should register the injour listener type with the servant' do
    File.stub!(:read).and_return ''

    CLI.stub!(:should_serve?).and_return false

    @servant.should_receive(:register_listener_type).with :injour, InjourListener

    CLI.execute @stdout, ['']
  end

  it 'should configure the servant with the given configuration file' do
    File.stub!(:expand_path).with('path/to/config/file').and_return '/full/path/to/config/file'
    File.stub!(:read).with('/full/path/to/config/file').and_return 'config'
    CLI.stub!(:should_serve?).and_return false

    @servant.should_receive(:instance_eval).with 'config', anything, anything

    CLI.execute @stdout, ['path/to/config/file']
  end

  it 'should use the full config file path and starting line number to allow for better error messages' do
    File.stub!(:expand_path).and_return '/full/path/to/config/file'
    File.stub!(:read)
    CLI.stub!(:should_serve?).and_return false

    @servant.should_receive(:instance_eval).with anything, '/full/path/to/config/file', 1

    CLI.execute @stdout, ['']
  end

  it 'should make the servant serve every 2 seconds' do
    File.stub!(:read).and_return ''
    CLI.stub!(:should_serve?).and_return true, false

    @servant.should_receive(:serve)
    CLI.should_receive(:sleep).with 2

    CLI.execute @stdout, ['']
  end

  it 'should display a startup message' do
    File.stub!(:read).and_return ''
    CLI.stub!(:should_serve?).and_return false

    CLI.execute @stdout, ['']

    @stdout.rewind
    @stdout.read.should match(/started/)
  end

  it 'should allow server to be stopped with an interrupt'

  it 'should allow polling period to be specified as an argument'

end
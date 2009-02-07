require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe CLI, "execute" do

  it 'should register the injour listener type with the servant'

  it 'should configure the servant with the given configuration file' do
    File.stub!(:read).with('path/to/config/file').and_return 'config'
    Servant.stub!(:new).and_return(servant = mock('Servant', :null_object => true))
    CLI.stub!(:should_serve?).and_return false

    servant.should_receive(:instance_eval).with 'config'

    CLI.execute @stdout_io, ['path/to/config/file']
  end

  it 'should make the servant serve every 5 seconds' do
    File.stub!(:read).and_return ''
    Servant.stub!(:new).and_return(servant = mock('Servant', :null_object => true))
    CLI.stub!(:should_serve?).and_return true, false

    servant.should_receive(:serve)
    CLI.should_receive(:sleep).with 5

    CLI.execute @stdout_io, ['']
  end

end
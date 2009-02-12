require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe Options, "execute" do

  before(:each) do
    @stdout = StringIO.new
  end

  it 'should display the usage message when no arguments are given' do
    Options.stub!(:exit)
    Options.from [], @stdout
    
    @stdout.rewind
    @stdout.read.should match(/Usage/)     
  end  
  
  it 'should display a help message when the help option is passed' do
    Options.stub!(:exit)
    Options.from ['-h'], @stdout
  
    @stdout.rewind
    @stdout.read.should match(/Usage/)
  end    
  
  it 'should recognise polling period' do
    Options.from(['-p', '5', '-c', 'config'], @stdout)[:polling_period].should == 5
  end
  
  it 'should default polling period to 2 seconds' do
    Options.from(['-c', 'config'], @stdout)[:polling_period].should == 2
  end
  
  it 'should expand configuration file path' do
    File.stub!(:expand_path).with('path/to/config/file').and_return '/full/path/to/config/file'
    Options.from(['-c', 'path/to/config/file'], @stdout)[:config_file].should == '/full/path/to/config/file'
  end
  
end
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'baldrick/servant'
require 'lib/baldrick/configuration_behaviour'

include Baldrick

describe Servant do

  it_should_behave_like 'a configurable object'

  before(:each) do
    @servant = Servant.new
  end

  it 'should execute all new orders from all listeners' do
    2.times do |listener_number|
      orders = [stub("order #{listener_number} a"), stub("order #{listener_number} b")]
      listener = mock("listener #{listener_number}", :new_orders => orders)
      @servant.add_listener listener

      orders.each {|order| @servant.should_receive(:follow).with order}
    end

    @servant.serve
  end

  it 'should perform all jobs for an executed order' do
    order = stub('order')
    @servant.add_listener mock('listener', :new_orders => [order])
    2.times do |job_number|

      @servant.add_job (job = mock("job #{job_number}"))

      job.should_receive(:run).with order
    end

    @servant.serve
  end

end
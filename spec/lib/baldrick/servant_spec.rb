require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'lib/baldrick/configuration_behaviour'

include Baldrick

describe Servant do

  it_should_behave_like 'a configurable object'

  before(:each) do
    @servant = Servant.new
  end

  it 'should execute all orders from all listeners' do
    2.times do |listener_number|
      orders = [stub("order #{listener_number} a"), stub("order #{listener_number} b")]
      listener = mock("listener #{listener_number}", :orders => orders)
      @servant.add_listener listener

      orders.each {|order| @servant.should_receive(:follow).with order}
    end

    @servant.serve
  end

  it 'should perform all tasks for an executed order' do
    order = stub('order')
    @servant.add_listener mock('listener', :orders => [order])
    2.times do |task_number|

      @servant.add_task(task = mock("task #{task_number}"))

      task.should_receive(:run).with order
    end

    @servant.serve
  end

end
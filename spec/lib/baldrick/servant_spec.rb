require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

include Baldrick

describe Servant do

  before(:each) do
    @servant = Servant.new
  end

  it 'executes all orders from all listeners' do
    2.times do |listener_number|
      orders = [stub("order #{listener_number} a"), stub("order #{listener_number} b")]
      listener = mock("listener #{listener_number}", :orders => orders)
      @servant.add_listener listener

      orders.each {|order| @servant.should_receive(:follow).with order}
    end

    @servant.serve
  end

  it 'performs all tasks for an executed order' do
    order = stub('order')
    @servant.add_listener mock('listener', :orders => [order])
    2.times do |task_number|

      @servant.add_task(task = mock("task #{task_number}"))

      task.should_receive(:run).with order
    end

    @servant.serve
  end
  
  it 'recovers from a problem with a listener and continues' do
    @servant.add_listener(first_listener = mock('first listener'))
    @servant.add_listener(second_listener = mock('second listener'))
    first_listener.stub!(:orders).and_raise Exception
    
    second_listener.should_receive(:orders).and_return []

    @servant.serve   
  end
end
When 'a new item appears in the feed containing an order' do
  server = File.dirname(__FILE__) + "/../resources/feed_server"
  ScenarioProcess.run "ruby #{server}", 'feed_server'
end

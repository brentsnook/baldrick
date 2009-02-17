When 'a new item appears in the feed containing an order' do
  server = File.dirname(__FILE__) + "/../resources/rss_server"
  ScenarioProcess.run "ruby #{server}", 'rss_server'
end

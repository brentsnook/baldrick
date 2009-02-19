Given 'a servant is listening for orders from $listener' do |listener|
  servant = File.dirname(__FILE__) + "/../resources/#{listener.downcase.gsub(' ', '_')}_servant"

  ScenarioProcess.run "ruby #{servant}", 'servant'
end
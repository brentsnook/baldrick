Given /^that a servant is listening for orders$/ do
  servant = File.dirname(__FILE__) + '/../resources/feature_servant'

  ScenarioProcess.run "ruby #{servant}", 'servant'
end
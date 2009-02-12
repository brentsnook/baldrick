Given /^that a servant is listening for orders$/ do
  bin_directory = File.dirname(__FILE__) + '/../../bin'
  feature_config = File.dirname(__FILE__) + '/../resources/config'

  ScenarioProcess.run "#{File.join(bin_directory, 'baldrick')} -c #{feature_config}", 'baldrick'
end
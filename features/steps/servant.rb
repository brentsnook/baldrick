Given /^that a servant is listening for orders$/ do
  bin_directory = File.dirname(__FILE__) + '/../../bin'
  feature_config = File.dirname(__FILE__) + '/../../bin'

  ScenarioProcess.run "#{File.join(bin_directory, 'baldrick')} -c #{feature_config}"
  # TODO: make sure the servant has started up properly
end
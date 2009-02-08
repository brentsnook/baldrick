Given /^that a servant is listening for orders$/ do
  bin_directory = File.dirname(__FILE__) + '/../../bin'
  feature_config = File.dirname(__FILE__) + '/../resources/config'

  puts "#{File.join(bin_directory, 'baldrick')} #{feature_config}"
  ScenarioProcess.run "#{File.join(bin_directory, 'baldrick')} #{feature_config}"
  # TODO: make sure the servant has started up properly
end
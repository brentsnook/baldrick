Before do
  CommandOutput.clear
  ScenarioProcess.run 'injour serve baldrickfeature 43216', 'injour_server'
end

After do
  ScenarioProcess.kill_all
end
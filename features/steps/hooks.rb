Before do
  CommandOutput.clear
  ScenarioProcess.run 'injour serve baldrickfeature 43216'
end

After do
  ScenarioProcess.kill_all
end
When 'an injour status is changed to contain an order' do
  ScenarioProcess.run 'injour serve baldrickfeature 43216', 'injour_server'
  ScenarioProcess.run 'injour status hey you, follow an order', 'injour_status'
end

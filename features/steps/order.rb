Then /^the order is followed$/ do
  CommandOutput.contents.should contain 'Order followed'
end
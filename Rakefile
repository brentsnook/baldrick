%w[rubygems rake rake/clean hoe fileutils newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/baldrick'

Hoe.spec 'baldrick' do
  version = Baldrick::VERSION
  developer 'Brent Snook', 'brent@fuglylogic.com'
  self.readme_file = 'README.rdoc'
  self.clean_globs |= %w[**/.DS_Store tmp *.log]
  self.rsync_args = '-av --delete --ignore-errors' # is this needed?
  
  self.extra_deps = [
    ['nokogiri','>= 1.1.1'],
  ]
  
  self.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"],
    ['rspec', '>= 1.1.12'],
    ['cucumber', '>= 0.1.16']
  ]
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

task :default => [:spec, :features]


%w[rubygems rake rake/clean fileutils newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/baldrick'

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.new('baldrick', Baldrick::VERSION) do |p|
  p.developer 'Brent Snook', 'brent@fuglylogic.com'
  p.summary = %q{Does what you tell it - glues orders to tasks.}
  p.changes = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.rubyforge_name = p.name
  p.extra_deps = [
    ['nokogiri','>= 1.1.1'],
  ]
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"],
    ['rspec', '>= 1.1.12'],
    ['cucumber', '>= 0.1.16'],
    ['injour', '>= 0.2.3'],
  ]
  
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  p.remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
  p.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

task :default => [:spec, :features]
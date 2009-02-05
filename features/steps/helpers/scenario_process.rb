class ScenarioProcess

  @processes = []

  def self.run command
    @processes << IO.popen(command)
  end

  def self.kill_all
    @processes.each {|process| Process.kill('KILL', process.pid)}
  end

end
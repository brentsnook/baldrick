class ScenarioProcess

  @commands = []

  def self.run command, name
    log = File.expand_path(File.dirname(__FILE__) + "/../../../tmp/#{name}.log")
    FileUtils.rm log, :force => true
    process = IO.popen "(#{command}) 2>&1 > #{log}"
    process.sync = true
    wait_for log

    @commands << command
  end

  def self.kill_all
    # this method of killing stuff is stinky....I long for something better
    @commands.each do |command|
      `ps`.each do |process|
        matches = process.match /(\d*).*#{command}/
        `kill #{matches[1]}` if matches
      end
    end  
  end

  private

  def self.wait_for file
    until File.exists? file
      sleep 0.2
    end
    
  end

end
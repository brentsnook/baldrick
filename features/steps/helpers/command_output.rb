class CommandOutput

  OUTPUT_FILE = File.expand_path(File.dirname(__FILE__) + '/../../../tmp/command_output')

  TIMEOUT = 10

  def self.contents
    wait_for {File.exists? OUTPUT_FILE and !file_contents.empty?}
    file_contents
  end

  def self.clear
    FileUtils.rm OUTPUT_FILE, :force => true
  end
 
  def self.add output
    File.open(OUTPUT_FILE, 'a') {|f| f.write(output) }
  end

  private

  def self.wait_for &condition
    time_spent = 0
    until yield or time_spent > TIMEOUT   
      sleep 0.5
      time_spent += 0.5
    end
  end

  def self.file_contents
    File.read OUTPUT_FILE
  end
end
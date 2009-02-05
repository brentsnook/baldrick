class CommandOutput

  OUTPUT_FILE = File.dirname(__FILE__) + '../../../tmp/command_output'

  def self.contents
    File.read OUTPUT_FILE
  end

  def self.clear
    FileUtils.rm OUTPUT_FILE, :force => true
  end

  def self.add output
    File.open(OUTPUT_FILE, 'a') {|f| f.write(output) }    
  end
  
end
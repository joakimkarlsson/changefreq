class Given
  attr_reader :test_data
  
  def initialize
    @test_data = TestData.new
  end
end                          

class TestData
         
  def initialize
    @logentries = []
  end
  
  def with
    self
  end  
  
  def logentry
    logentry = LogEntry.new 
    @logentries << logentry
    logentry
  end
  
  def start
    @lines = []
    @logentries.each do |entry|
      @lines << "Commit message"
      @lines << "------------------------------------------------------------------------"
      @lines << "r1 | user | " + entry.date.to_s + " 22:08:01 +0200 (Thu, 28 May 2009) | 1 line"
      @lines << "Changed paths"
      entry.paths.each do |path|
        @lines << "M " + path
      end 
      @lines << ""
    end 
    @current_line = 0  
  end
  
  def readline 
    raise EOFError if @current_line >= @lines.length
    @current_line += 1
    @lines[@current_line-1]
  end  

end 

class LogEntry  
  attr_reader :paths, :date
  
  def initialize
    @paths = []
  end
  
  def with
    self
  end 
  
  def at_date(date)
    @date = date
    self
  end 
  
  def path(path)
    @paths << path
  end 
  
end
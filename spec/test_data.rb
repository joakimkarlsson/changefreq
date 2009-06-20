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
  
  def to_xml
    xml = '<log>'
    @logentries.each do |entry| 
      xml += '<logentry>'
      xml += '<date>' + entry.date + '</date>'
      xml += '<paths>'
      entry.paths.each do |path|
        xml += '<path>' + path + '</path>'
      end                                   
      xml += '</paths>'
      xml += '</logentry>'
    end 
    xml += '</log>'
    xml
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
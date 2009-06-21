#0 1 2 3 4 5 6 7 8 9 10 11 12 13 14- 21- 28- 35- 56- 77- 98- 140- 182- 224- 308- 392- 
#1                               7   7   7   21  21  21  42  42   42   84   84   
   
class Frequency    
  attr_reader :count, :name, :lower_limit, :upper_limit
  
  def initialize(name, lower_limit, upper_limit)
    @name = name
    @count = 0 
    @lower_limit = lower_limit
    @upper_limit = upper_limit
  end
  
  def is_within(data)
    @lower_limit <= data && data <= @upper_limit
  end
  
  def increase
    @count += 1
  end
end

class Histogram      
  attr_reader :frequencies 
  attr_reader :indexes
  
  def initialize(log)                                                                
    @frequencies = [ Frequency.new("0 days", 0, 0), Frequency.new("1 days", 1, 1), Frequency.new("2 days", 2, 2),
      Frequency.new("3 days", 3, 3), Frequency.new("4 days", 4, 4), Frequency.new("5 days", 5, 5), Frequency.new("6 days", 6, 6),
      Frequency.new("7 days", 7, 7), Frequency.new("8 days", 8, 8), Frequency.new("9 days", 9, 9), Frequency.new("10 days", 10, 10),
      Frequency.new("11 days", 11, 11), Frequency.new("12 days", 12, 12), Frequency.new("13 days", 13, 13), Frequency.new("14-20 days", 14, 20),
      Frequency.new("21-27 days", 21, 27), Frequency.new("28-34 days", 28, 34), Frequency.new("35-55 days", 35, 55),
      Frequency.new("56-76 days", 56, 76), Frequency.new("77-97 days", 77, 97), Frequency.new("98-139 days", 98, 139),
      Frequency.new("140-181 days", 140, 181), Frequency.new("182-223 days", 182, 223), Frequency.new("224-307 days", 224, 307),
      Frequency.new("308-391 days", 308, 391), Frequency.new("392 days and up", 392, 9998), Frequency.new("Files never changed", 9999, 9999)]
      
    log.paths.each do |path,dates|

      if dates.size == 1 
        add_frequency_for(9999)  
      end

      i=dates.size-1
      while i>0                     
        add_frequency_for(dates[i]-dates[i-1])
        i -= 1
      end
    end    
  end       
 
  
  def add_frequency_for(delta)
    @frequencies.each do |freq|
      freq.increase if freq.is_within(delta)
    end   
  end
    
end


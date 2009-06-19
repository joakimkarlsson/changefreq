#0 1 2 3 4 5 6 7 8 9 10 11 12 13 14- 21- 28- 35- 56- 77- 98- 140- 182- 224- 308- 392- 
#1                               7   7   7   21  21  21  42  42   42   84   84   

class Histogram      
  attr_reader :frequencies 
  attr_reader :indexes
  
  def initialize(log)                                                                
    
    @indexes = {"0" => 0, "1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, 
      "10" => 10, "11" => 11, "12" => 12, "13" => 13, "14" => 14, "21-27" => 15, "28-34" => 16, "35-55" => 17, "56-76" => 18, 
      "77-97" => 19, "98-139" => 20, "140-181" => 21, "182-223" => 22, "224-307" => 23, "308-391" => 24, "392-" => 25, "once" => 26} 
 
 
    @frequencies = [[0,0], [1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0], [8,0], [9,0], [10,0], [11,0], [12,0], 
    [13,0], [14,0], [21,0], [28,0], [35,0], [56,0], [77,0], [98,0], [140,0], [182,0], [224,0], [308,0], [392,0], [9999,0]]
      
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
    (@frequencies.length-1).downto(0) do |i| 
      if delta >= @frequencies[i][0]
        @frequencies[i][1] += 1  
        break
      end
    end  
  end
    
end


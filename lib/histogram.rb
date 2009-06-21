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
    @frequencies = [ Frequency.new("Same Week", 0, 6), Frequency.new("1 Week", 7, 13), Frequency.new("2 Weeks", 14, 20),
      Frequency.new("3 Weeks", 21, 27), Frequency.new("4 Weeks", 28, 34), Frequency.new("5 Weeks", 35, 41), Frequency.new("6 Weeks", 42, 48),
      Frequency.new("7 Weeks", 49, 55), Frequency.new("8 Weeks", 56, 62), Frequency.new("9 Weeks", 63, 69), Frequency.new("10 Weeks", 70, 76),
      Frequency.new("11 Weeks", 77, 83), Frequency.new("12 Weeks", 84, 90), Frequency.new("13 Weeks", 91, 97), Frequency.new("14 Weeks", 98, 104),
      Frequency.new("15 Weeks", 105, 111), Frequency.new("16 Weeks", 112, 118), Frequency.new("17 Weeks", 119, 125),
      Frequency.new("18 Weeks", 126, 132), Frequency.new("19 Weeks", 133, 139), Frequency.new("20 Weeks", 140, 146),
      Frequency.new("21 Weeks", 147, 153), Frequency.new("22 Weeks", 154, 160), Frequency.new("23 Weeks", 161, 167),
      Frequency.new("24 Weeks", 168, 174), Frequency.new("25 Weeks", 175, 181), Frequency.new("26 Weeks", 182, 188),
      Frequency.new("27 Weeks", 189, 195), Frequency.new("28 Weeks", 196, 202), Frequency.new("29 Weeks", 203, 209),
      Frequency.new("30 Weeks", 210, 216), Frequency.new("31 Weeks", 217, 223), Frequency.new("32 Weeks", 224, 230),
      Frequency.new("33 Weeks", 231, 237), Frequency.new("34 Weeks", 238, 244), Frequency.new("35 Weeks", 245, 251),
      Frequency.new("36 Weeks", 252, 258), Frequency.new("37 Weeks", 259, 265), Frequency.new("38 Weeks", 266, 272),
      Frequency.new("39 Weeks", 273, 279), Frequency.new("40 Weeks", 280, 286), Frequency.new("41 Weeks", 287, 293),
      Frequency.new("42 Weeks", 294, 300), Frequency.new("43 Weeks", 301, 307), Frequency.new("44 Weeks", 308, 314),
      Frequency.new("45 Weeks", 315, 321), Frequency.new("46 Weeks", 322, 328), Frequency.new("47 Weeks", 329, 335),
      Frequency.new("48 Weeks", 336, 342), Frequency.new("49 Weeks", 343, 349), Frequency.new("50 Weeks", 350, 356),
      Frequency.new("51 Weeks", 357, 364), Frequency.new("Over a year", 365, 9998), Frequency.new("Files never changed", 9999, 9999)]
      
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


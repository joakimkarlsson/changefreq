class SvnLogParser  
  attr_reader :paths
  
  def initialize
    @paths = {} 
    @filter = nil
  end
  
  def parse(input) 
    while true 
      info = find_info_line(input)

      date = Date.parse(info.split('|')[2].strip.split(' ')[0]) 
    
      changed_paths_header = input.readline

      path = input.readline.strip
      until path.empty?
        add_changedate_for_path(path.strip[2, path.length-1], date) if matches_filter(path)
        path = input.readline.strip
        end 
    end
    
    rescue EOFError
  
  end
  
  def find_info_line(input)
    while true
      line = input.readline
      return input.readline if line.strip == '------------------------------------------------------------------------'
    end
  end
  
  def add_changedate_for_path(path, date) 
    @paths[path] ||= []
    @paths[path].insert(0, date)  
  end 

  def filter=(filters) 
    @filter = nil
    @filter = filters.split(';') unless filters == nil || filters == ""
  end
  
  def matches_filter(text) 
    return true if @filter.nil?
    @filter.each do |f|
      return true if File.fnmatch(f, text) 
    end
    false
  end  
end

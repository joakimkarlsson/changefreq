require 'rexml/document'
require 'date' 

class LogParser  
  attr_reader :paths
  
  def initialize
    @paths = {} 
    @filter = nil
  end
  
  def parse(input) 
    while true 
      info = find_info_line(input)

      date = Date.parse(info.split('|')[2].strip.split(' ')[0]) 
    
      changed_paths_header = readline_from(input)

      path = readline_from(input).strip
      until path.empty?
        add_changedate_for_path(path.strip[2, path.length-1], date) if matches_filter(path)
        path = readline_from(input).strip
        end 
    end
    
    rescue EOFError
  
  end

  def readline_from(input)
    line = input.readline
    if line.nil?
      puts "Read nil line!"
    end
    line
  end
  
  def find_info_line(input)
    while true
      line = readline_from(input)
      return readline_from(input) if line.strip == '------------------------------------------------------------------------'
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

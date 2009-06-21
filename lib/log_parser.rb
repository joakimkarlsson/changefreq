require 'rexml/document'
require 'date' 

class LogParser  
  attr_reader :paths
  
  def initialize
    @paths = {} 
    @filter = nil
  end
  
  def parse(input)
    line = input.readline
    while true
      comment = line
      separator = input.readline
      info = input.readline
      info_fields = info.split('|') 
      revision = info_fields[0].strip
      user = info_fields[1].strip
      date = Date.parse(info_fields[2].strip.split(' ')[0]) 
      lines = info_fields[3].strip
    
      changed_paths_header = input.readline

      path = input.readline
      until path.empty?
        add_changedate_for_path(path[2, path.length-1], date) if matches_filter(path)
        path = input.readline
        end
      
      line = input.readline 
    end
    
    rescue EOFError
  
  end  
  
  def add_changedate_for_path(path, date) 
    @paths[path] ||= []
    @paths[path].insert(0, date)  
  end 

  def filter=(filters)
    @filter = filters.split(';')
  end
  
  def matches_filter(text) 
    return true if @filter.nil?
    @filter.each do |f|
      return true if File.fnmatch(f, text) 
    end
    false
  end  
end

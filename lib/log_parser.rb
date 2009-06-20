require 'rexml/document'
require 'date' 

class LogParser  
  attr_reader :paths
  
  def initialize
    @paths = {}
  end
  
  def parse(input)     
    doc = REXML::Document.new(input)
    doc.elements.each('//logentry') do |e|
      date = Date.parse(e.elements['date'].text)
                                
      e.elements.each('.//path') do |path|
        add_changedate_for_path(path.text, date) if matches_filter(path.text)
      end   
    end  
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

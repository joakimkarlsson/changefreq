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
        add_changedate_for_path(path.text, date)
      end   
    end  
  end  
  
  def add_changedate_for_path(path, date) 
    @paths[path] ||= []
    @paths[path].insert(0, date)  
  end
end

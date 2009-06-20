require 'lib/histogram'
require 'lib/log_parser'

describe Histogram do

  before(:each) do     
    @log = LogParser.new
  end

  it "should find the correct number of times a file has changed within a day" do
    @log.add_changedate_for_path('/the/path', Date.parse('2009-01-01'))
    @log.add_changedate_for_path('/the/path', Date.parse('2009-01-01'))

    h = Histogram.new(@log)
 
    h.frequencies[0][1].should == 1  
  end 
  
  it "should put a file changed within 7 days correctly in the histogram" do
    @log.add_changedate_for_path('/the/path', Date.parse('2009-01-08'))
    @log.add_changedate_for_path('/the/path', Date.parse('2009-01-01'))
               
    h = Histogram.new(@log)          
               
    h.frequencies[7][1].should == 1      
  end 
  
  it "should put a file changed after over a year last in the histogram" do
    @log.add_changedate_for_path('/the/path', Date.parse('2010-06-01'))
    @log.add_changedate_for_path('/the/path', Date.parse('2009-01-01'))
               
    h = Histogram.new(@log)          
               
    h.frequencies[h.indexes["392-"]][1].should == 1      
  
  end  
  
  it "should be able to accumulate changes to several files" do
    @log.add_changedate_for_path('/the/path', Date.parse('2010-06-01'))
    @log.add_changedate_for_path('/the/path', Date.parse('2009-01-01'))
               
    h = Histogram.new(@log)          
               
    h.frequencies[h.indexes["392-"]][1].should == 1 
  end
  
  it "should store a file that's only been changed once (i.e. just added to the repo) is stored correctly" do
    @log.add_changedate_for_path('/the/path', Date.parse('2009-01-01'))
               
    h = Histogram.new(@log)          
               
    h.frequencies[h.indexes["once"]][1].should == 1 
      
  end     
    
end
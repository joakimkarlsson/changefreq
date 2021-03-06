require 'lib/histogram'
require 'lib/svn_log_parser'
require 'spec/test_data'

describe Histogram do

  before(:each) do     
    @log = SvnLogParser.new
    @given = Given.new
  end

  it "should collect a file change within a day in category 0" do 
    @given.test_data.with.logentry.at_date('2009-01-01').with.path('/the path')
    @given.test_data.with.logentry.at_date('2009-01-01').with.path('/the path')  
    @given.test_data.start               
                
    @log.parse(@given.test_data) 
    
    h = Histogram.new(@log)
 
    h.frequencies[0].count.should == 1  
  end 
  
  it "should put a file changed within 7 days correctly in the histogram" do
    @given.test_data.with.logentry.at_date('2009-01-08').with.path('/the path')
    @given.test_data.with.logentry.at_date('2009-01-01').with.path('/the path')                          
    @given.test_data.start

    @log.parse(@given.test_data) 
               
    h = Histogram.new(@log)          
               
    h.frequencies[7].count.should == 1      
  end 
  
  it "should put a file changed after over a year last in the histogram" do
    @given.test_data.with.logentry.at_date('2010-06-01').with.path('/the path')
    @given.test_data.with.logentry.at_date('2009-01-01').with.path('/the path')                          
    @given.test_data.start

    @log.parse(@given.test_data) 
               
    h = Histogram.new(@log)          
                           
    h.frequencies[-2].name.should == "392 days and up"
    h.frequencies[-2].count.should == 1      
  
  end  
    
  it "should store a file that's only been changed once (i.e. just added to the repo) is stored correctly" do
    @given.test_data.with.logentry.at_date('2009-01-01').with.path('/the path')
    @given.test_data.start

    @log.parse(@given.test_data) 
               
    h = Histogram.new(@log)          
    
    h.frequencies[-1].name.should == "Files never changed"           
    h.frequencies[-1].count.should ==1 
      
  end     
    
end
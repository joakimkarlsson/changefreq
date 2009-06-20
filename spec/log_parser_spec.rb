require 'lib/log_parser' 
require 'spec/test_data'

describe LogParser do   
  before(:each) do     
    @log_parser = LogParser.new 
    @given = Given.new
  end 

  it "should store a file and the date its been modified" do  
    @given.test_data.with.logentry.at_date('2009-05-28').with.path('/the path')
                            
    @log_parser.parse(@given.test_data.to_xml)

    @log_parser.paths['/the path'].should include(Date.parse('2009-05-28')) 
  end
  
  it "should store the dates a file has been changed in ascending order" do
    @given.test_data.with.logentry.at_date('2009-05-28').with.path('/the path')
    @given.test_data.with.logentry.at_date('2009-05-27').with.path('/the path')
    @given.test_data.with.logentry.at_date('2009-05-26').with.path('/the path')
                            
    @log_parser.parse(@given.test_data.to_xml)

    @log_parser.paths['/the path'][0].should == Date.parse('2009-05-26') 
    @log_parser.paths['/the path'][1].should == Date.parse('2009-05-27') 
    @log_parser.paths['/the path'][2].should == Date.parse('2009-05-28')   
  end 
  
  it "should only store files that matches a filter" do
    @given.test_data.with.logentry.at_date('2009-05-28').with.path('/the path/file.cpp')
    @given.test_data.with.logentry.at_date('2009-05-28').with.path('/the path/file.doc')
     
    @log_parser.filter = "*.cpp"
    @log_parser.parse(@given.test_data.to_xml)
    
    @log_parser.paths.should include('/the path/file.cpp')
    @log_parser.paths.should_not include('/the path/file.doc')
    
  end 
  
  it "should only store files that matches a filter with multiple designators" do
    @given.test_data.with.logentry.at_date('2009-05-28').with.path('/the path/file.cpp')
    @given.test_data.with.logentry.at_date('2009-05-28').with.path('/the path/file.h')
    @given.test_data.with.logentry.at_date('2009-05-28').with.path('/the path/file.doc')
     
    @log_parser.filter = "*.cpp;*.h"
    @log_parser.parse(@given.test_data.to_xml)
    
    @log_parser.paths.should include('/the path/file.cpp')
    @log_parser.paths.should include('/the path/file.h')
    @log_parser.paths.should_not include('/the path/file.doc')
    
  end
end    

require 'lib/log_parser'

describe LogParser do   
      
  before(:each) do     
    @input = File.open('spec/testdata.xml').read
    @log_parser = LogParser.new 
    @log_parser.parse(@input)
  end

  it "should store a file and all the dates its been modified" do   
    expected_date = Date.parse('2009-05-28T20:08:01.049484Z')
    file_to_test = '/vendor/plugins/auto_complete/test/auto_complete_test.rb'
    @log_parser.paths[file_to_test].should include(expected_date) 
  end
  
end
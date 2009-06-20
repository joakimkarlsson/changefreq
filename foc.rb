#!/usr/bin/env ruby -wKU

require 'rubygems' 
require 'commandline'
require 'lib/log_parser'
require 'lib/histogram'

class ChangeStats < CommandLine::Application
  def initialize
    synopsis "[--filter <filter>] logfile"
    options :help
    option :names => "--filter", :opt_found => get_args,
     :opt_description => "Filter for what files to include (e.g. *.cpp;*.h)",
     :arg_description => "filter"
    expected_args :logfile
  end                    
  
  def main    
    log = LogParser.new
    log.filter = opt.filter
    log.parse(File.open(@logfile).read)
    
    histogram = Histogram.new(log)
    
    f = histogram.frequencies
    f.each do |freq|
      puts "#{freq.name}\t#{freq.count}" 
    end
   
  end
end
                         




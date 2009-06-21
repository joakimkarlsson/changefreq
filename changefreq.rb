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
     :arg_description => "filter", :opt_not_found => ""
    expected_args :logfile
  end                    
  
  def main    
    log = LogParser.new
    log.filter = "" #opt.filter
    @logfile = "python.svnlog"
    log.parse(File.open(@logfile))
    
    histogram = Histogram.new(log)
    
    f = histogram.frequencies
    f.each do |freq|
      print "#{freq.name}\t" 
    end
    
    puts
     
    f = histogram.frequencies
    f.each do |freq|
      print "#{freq.count}\t" 
    end   
  end
end

cs = ChangeStats.new
cs.main
                         



#!/usr/bin/env ruby -wKU

require 'lib/log_parser'
require 'lib/histogram'
                         
logfile = ARGV[0]

xml = File.open(logfile).read 
log_parser = LogParser.new 
log_parser.parse(xml) 
      
histogram = Histogram.new(log_parser)
                                    
f = histogram.frequencies
f.each do |freq|
  print "#{freq[1]}\t" 
end

puts

f.each do |freq|
  print "#{freq[0]}\t" 
end 

puts





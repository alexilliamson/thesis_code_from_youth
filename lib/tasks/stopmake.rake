require 'rubygems'
require 'watir-webdriver'
require 'pry'
require 'CSV'

task :stopmake => :environment do
	stopwords = []
  File.new("stop_input.txt","r+").each_line{|line|
  	line.gsub!(/[^A-Za-z]/,'').downcase!
  	stopwords = stopwords << line
  }

  output = File.new("stop_output.txt","r+")

   stopwords.each {|s| 
    output.puts("\"#{s}\"\,")
  }
  output.close


end
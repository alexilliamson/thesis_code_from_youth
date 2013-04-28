require 'rubygems'
require 'watir-webdriver'
require 'pry'

task :info => :environment do
  file = File.new("speakerinfo.txt","r+")
  info = []
  file.each_line {|line| info = info << line}
  info.each_index{|i| info[i] = info[i].split(',')}

  Speaker.find_each {|a|
    update = info.select {|line| (a.name == line[0]) and (a.year == line[1].to_i) and (a.branch == line[4].gsub(/[^A-Za-z]/,''))}
    update.flatten!

    if update.size == 6
      puts(a.id)
      puts("#{update}")
      a.assign_attributes({ :party =>update[2], :score => update[3], :score2 =>update[5]})
      a.save
      puts('HERE')
    end
  }

  file.close



end
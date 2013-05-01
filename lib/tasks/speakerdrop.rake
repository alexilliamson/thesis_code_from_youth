require 'rubygems'
require 'stemmify'
require 'pry'

task :parse => :environment do
    Speaker.where(:party => nil).find_each{|s| s.destroy}
end



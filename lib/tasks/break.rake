require 'rubygems'
require 'watir-webdriver'
require 'pry'


task :break => :environment do
	Result.includes(:phrase).order(:slope).all.each {|a|
		puts(a.phrase.text)
		puts(a.slope)}
end


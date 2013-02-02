require 'rubygems'
require 'watir-webdriver'

lib_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

task :scrape => :environment do
  browser = Watir::Browser.new
  browser.goto "http://bit.ly/watir-example"
end
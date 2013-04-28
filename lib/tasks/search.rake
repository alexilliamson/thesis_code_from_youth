require 'rubygems'
require 'watir-webdriver'
require 'pry'


task :search => :environment do
  browser = Watir::Browser.new
  browser.goto "http://search.proquest.com.turing.library.northwestern.edu/?accountid=12861&selectids=1005880,1006091,1007871,1007272,1006744,1007624,1005879,1006442,1005877,1005878,1006151,1006466,1008419,1006051,1007155,1005685,1007154,1006359"
  browser.text_field(:name => 'IDToken1').set "abw724"
  browser.text_field(:name => 'IDToken2').set "@4k5k6k7"
  browser.button(:name => 'Login.Submit').click
end
require 'rubygems'
require 'watir-webdriver'
require 'pry'

task :scrape => :environment do


  browser = Watir::Browser.new
  browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC'
  years = Array.new
  browser.links(:text => /\s*[12][09][019][0-9]\s*\z/).each{|link| years = years << link.text}
  years = years.drop(1)

  years.each {|year|
    congress = (year.to_i - 1994)/2 +103
    browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
    browser.link(:text => year).click
    months = Array.new
    browser.links(:text => /^[JFMASOND][a-hj-z][a-z]{,8}\z/).each{|link| months = months << link.text}

    months.each {|month|
      browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
      browser.link(:text => year).click
      browser.link(:text => month).click
      days = Array.new
      browser.links(:text => /day, /).each{|link| days = days << link.text}

      days.each {|day|
        browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
        browser.link(:text => year).click
        browser.link(:text => month).click
        browser.link(:text => day).click
        sections = Array.new
        browser.links(:text => /(Senate|House)/).each{|link| sections = sections << link.text}

        sections.each {|section|
          browser.goto 'http://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC' 
          browser.link(:text => year).click
          browser.link(:text => month).click
          browser.link(:text => day).click
          browser.link(:text => section).click
          pages = Array.new
          browser.links(:text => 'Text').each{|link| pages = pages << link.href}

          pages.each {|page|
            browser.goto page
            text = browser.text
            text = text.gsub(/Mrs. /, "Mr. ")
            text = text.gsub(/Ms. /, "Mr. ")
            names = text.scan(/([MT][rh]. [A-Z].[A-Z]{1,}*\.|[MT][rh]. [A-Z].[A-Z]{1,} of [A-Z][a-z]*\.)/)
            sections = text.split(/[MT][rh]. [A-Z].[A-Z]{1,}*\./)
            sections.slice!(0)
            names.flatten!
            title = page
            sections.each_index {|i|
              if /Mr\./ =~ names[i]
                name = (names[i].gsub(/Mr. /, '')).upcase.gsub(/[^a-zA-Z ]/,'')
                speaker = Speaker.find_or_create_by_name_and_year_and_branch(:name => name, :year => year.to_i, :branch => section)
                passage = speaker.passages.create(:title => title , :text => sections[i])
              end
            }
          }

        }
      }
    }
  }

  browser.close

end
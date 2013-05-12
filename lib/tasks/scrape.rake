require 'rubygems'
require 'watir-webdriver'
require 'pry'

task :scrape => :environment do
  puts(Time::now)
  Watir::Wait.until(500) { 
    browser = Watir::Browser.new
    File.new("links1994.txt","r+").each_line {|page|
      browser.goto page
      @year = page[34..37]
      case page[72]
      when 'S'
        @section = 'Senate'
      when 'H'
        @section = 'House'
      else
        @section = 'X'
      end
      text = browser.text
      text.gsub!(/Mrs. /, "Mr. ")
      text.gsub!(/Ms. /, "Mr. ")
      text.gsub!(/The PRESIDING OFFICER/, "Mr. PRESIDINGOFFICER")
      text.gsub!(/The SPEAKER PRO TEMPORE/, "Mr. SPEAKERPROTEMPORE")
      text.gsub!(/The PRESIDENT PRO TEMPORE/, "Mr. PRESPROTEMPORE")
      text.gsub!(/The CLERK/, "Mr. SPEAKERPROTEMPORE")
      text.gsub!(/The PRESIDENT/, "Mr. PRESIDENT")
      text.gsub!(/The VICE PRESIDENT/, "Mr. VPRESIDENT")
      text.gsub!(/The SPEAKER/, "Mr. SPEAKER")
      text.gsub!(/The [A-Z]+/,"Mr. WHATIS")

      names = text.scan(/([MT][rh]. [A-Z].[A-Z]{1,}*\.|[MT][rh]. [A-Z].[A-Z]{1,} of [A-Z][a-z]*\.)/)
      sections = text.split(/[MT][rh]. [A-Z].[A-Z]{1,}*\./)
      sections.slice!(0)
      names.flatten!
      sections.each_index {|i|
        if /Mr\./ =~ names[i]
          @name = (names[i].gsub(/Mr. /, '')).upcase.gsub(/[^a-zA-Z ]/,'')
          @speaker = Speaker.find_or_create_by_name_and_year_and_branch(:name => @name, :year => @year.to_i, :branch => @section)
          @passage = @speaker.passages.create(:title => page , :text => sections[i])
        end
      }
    }
    browser.close
  }

  
  puts(Time::now)

end
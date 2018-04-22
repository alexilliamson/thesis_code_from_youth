require 'rubygems'
require 'watir-webdriver'
require 'pry'

task :scrape2 => :environment do
  puts(Time::now)
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 180 # seconds – default is 60

  browser = Watir::Browser.new :firefox, :http_client => client
  File.new("links2012.txt","r+").each_line {|page|
      browser.goto page
      @year = page[34..37]

      case page[72]
      when 'S'
        @branch= 'S'
      when 'H'
        @branch = 'H'
      else
      end

      text = browser.text
      text.gsub!(/Ms\. /, "Mr. ")
      text.gsub!(/Mrs\. /, "Mr. ")
      text.gsub!(/Mr\. PETE GEREN/, "Mr. GEREN")
      text.gsub!(/Mr\. [A-Z]+ [A-Z]+/) {|a| "Mr. " + a.split[1] + a.split[2]}
      text.gsub!(/Mr\. DE LUGO/, "Mr. DELUGO")
      text.gsub!(/GARZA/, "Mr. DELAGARZA")
      text.gsub!(/-/, "")
      text.gsub!(/The PRESIDING OFFICER/, "Mr. PRESIDINGOFFICER")
      text.gsub!(/The SPEAKER PRO TEMPORE/, "Mr. SPEAKERPROTEMPORE")
      text.gsub!(/The SPEAKER pro tempore/, "Mr. SPEAKERPROTEMPORE")
      text.gsub!(/The SPEAKER pro tempore \(.*\)/, "Mr. SPEAKERPROTEMPORE")
      text.gsub!(/DesJARLAIS/,"DESJARLAIS")
      text.gsub!(/The PRESIDENT PRO TEMPORE/, "Mr. PRESPROTEMPORE")
      text.gsub!(/The CLERK/, "Mr. CLERK")
      text.gsub!(/The PRESIDENT/, "Mr. PRESIDENT")
      text.gsub!(/The ACTING PRESIDENT/, "Mr. PRESIDENT")
      text.gsub!(/The VICE PRESIDENT/, "Mr. VPRESIDENT")
      text.gsub!(/The SPEAKER/, "Mr. SPEAKER")
      text.gsub!(/The CHAIRMAN/, "Mr. CHAIRMAN")
      text.gsub!(/The CHAIRMAN/, "Mr. CHAIRMAN")
      text.gsub!(/PUBLIC BILLS AND RESOLUTIONS.*/m,'')
      text.gsub!(/THE JOURNAL.*/m,'')
      text.gsub!(/PLEDGE OF ALLEGIANCE.*____/m,'') 
     text.gsub!(/\[Roll No.*?So /m,'')
      text.gsub!(/\n   .* \n/,"\n")
      text.gsub!(/\n   .* \n/,"\n")
      text.gsub!(/\n   .* \n/,"\n")
      text.gsub!(/\n   .* \n/,"\n")
      text.gsub!(/\n   .* \n/,"\n")
      text.gsub!(/\n   .* \n/,"\n")
      text.gsub!(/\n   .* \n/,"\n")
      text.gsub!(/Mr\. .*\(for h/,'')
      text.gsub!(/Mr. .* offered amendment/,'')
      text.gsub!(/\(Mr\. .* asked/,'')
      text.gsub!(/\(during the reading\)\./,'.')
      text.gsub!('addressed the chair.','.')


      names = text.scan(/(Mr\. [A-Z][^\.][A-Z]{1,}*\.|Mr\. [A-Z].[A-Z]{1,} of [A-Z][a-z]*[\.\: ][A-Za \n])/)
      sections = text.split(/Mr\. [A-Z][^\.][A-Z]{1,}*[\. ][o ][^n]/)
      sections.slice!(0)
      names.flatten!
  

      if sections.size>0 and sections.size == names.size
        sections.each_index {|i|
          
            @name = (names[i].gsub(/Mr. /, '')).upcase.gsub(/[^a-zA-Z ]/,'')
            @person = Person2.find_or_create_by_name_and_branch(:name => @name, :year=> 2012, :branch => @branch)
            @page = @person.page2s.create(:title => page , :text => sections[i])

        }
      elsif sections.size != names.size
        puts("FUCKKK",page)
      end
    }
    browser.close

  
  puts(Time::now)

end
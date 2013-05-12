require 'rubygems'
require 'watir-webdriver'
require 'pry'


task :search => :environment do

	links = []
	words = ["\"gun\"","\"people\""]
	browser = Watir::Browser.new
	browser.goto "http://infoweb.newsbank.com.turing.library.northwestern.edu/iw-search/we/InfoWeb?p_field_base-0=&p_text_base-0=&p_params_base-0=&p_bool_base-1=and&p_field_base-1=YMD_date&p_text_base-1=Jan+1994+-+Dec+1994&p_params_base-1=&p_bool_base-2=and&p_field_base-2=YMD_date&p_text_base-2=&p_params_base-2=&p_sort=_rank_%3AD&p_product=AWNB&p_theme=aggregated5&p_action=search&d_loc=world&d_fieldcount=3&f_lastaction=explore&f_dateparams=B%2CE&f_submit_loc=loc&d_place=&d_selSrc=&d_selSrc=TTTB&d_selSrc=CCCB&d_selSrc=BGNB&d_selSrc=VNRB&d_selSrc=PNPB&d_selSrc=SBTS&d_selSrc=BSHB&d_selSrc=AGCB&d_selSrc=DHGB&d_selSrc=ADGL&d_selSrc=ABMA&d_selSrc=DCDT&d_selSrc=WSNB&d_selSrc=VCBB&d_selSrc=HNN9&d_selSrc=SMRB&d_selSrc=SMRI&d_selSrc=MTGB"
	browser.text_field(:name => 'IDToken1').set "abw724"
	browser.text_field(:name => 'IDToken2').set "@4k5k6k7"
	browser.button(:name => 'Login.Submit').click
	browser.link(:text => 'North America').click
	browser.link(:text => 'United States').click
	browser.button(:text=> 'Source Types').click
	browser.link(:text => 'Newspapers').click
	browser.button(:text => 'Source List').click
	url = browser.url

	year = 1994
	browser.table.rows.each {|row| 
		puts(row[2].text[6..9])
		puts(row[2].text[17..20].to_i)
		puts(row[2].text[17..20])

		if row[2].text[6..9].to_i <= year and (row[2].text[17..20].to_i >= year or row[2].text[17..20] == 't')
			links << row[1].link.href
		end
	}
	puts(links)

	links.each {|link|

		browser.goto link
		date = browser.div(:class => "info-date").text
		puts(date)
		search = ""
		words.each{|word|
		search = search + "\"" + word + "\"" + "or"
		}
		search.gsub!(/or$/, '')
		browser.text_field(:name => 'p_text_base-0').set search
		browser.text_field(:id => 'searchText-2-dateInput').set "Jan #{year} - Dec #{year}"
		browser.button(:text=> 'f_submit_search').click
		

		#count function goes here


	


	}
	# browser.close
  
end
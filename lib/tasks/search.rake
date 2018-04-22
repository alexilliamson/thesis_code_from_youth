require 'rubygems'
require 'watir-webdriver'
require 'pry'

#ADDindextermsfrompublishercriteria


task :search => :environment do
	texts94 = []
	dim1S94= Word.where('chi2 > 0 and branch = ?','S').order('chi2 DESC').limit(5000).pluck(:stem)
	dim1H94 = Word.where('chi2 > 0 and branch = ?','H').order('chi2 DESC').limit(5000).pluck(:stem)
	dim2S94= Word.where('chib > 0 and branch = ?','S').order('chib DESC').limit(5000).pluck(:stem)
	dim2H94= Word.where('chib > 0 and branch = ?','H').order('chib DESC').limit(5000).pluck(:stem)
	stems194 = Word.select('stem, avg(chi2)').where('chi2 > 0 and stem IN (?)', (dim1S94 & dim1H94)).group(:stem).order('avg(chi2) DESC').limit(350).pluck(:stem).uniq
	stems294 = Word.select('stem, avg(chib)').where('chib > 0 and stem IN (?)', (dim2S94 & dim2H94)).group(:stem).order('avg(chib) DESC').limit(150).pluck(:stem).uniq
	stems94 = stems194 << stems294
	stems94.flatten!.uniq!
	stems94.each {|stem| texts94 = texts94 << Word.where(:stem => stem).first.text }


	texts12 = []
	dim1S12= Word2.where('chi2 > 0 and branch = ?','S').order('chi2 DESC').limit(5000).pluck(:stem)
	dim1H12= Word2.where('chi2 > 0 and branch = ?','H').order('chi2 DESC').limit(5000).pluck(:stem)
	dim2S12= Word2.where('chib > 0 and branch = ?','S').order('chib DESC').limit(5000).pluck(:stem)
	dim2H12= Word2.where('chib > 0 and branch = ?','H').order('chib DESC').limit(5000).pluck(:stem)	
	stems112 = Word2.select('stem, avg(chi2)').where('chi2 > 0 and stem IN (?)', (dim1S12 & dim1H12)).group(:stem).order('avg(chi2) DESC').limit(350).pluck(:stem).uniq
	stems212 = Word2.select('stem, avg(chib)').where('chib > 0 and stem IN (?)', (dim2S12 & dim2H12)).group(:stem).order('avg(chib) DESC').limit(150).pluck(:stem).uniq
	stems12 = stems112 << stems212
	stems12.flatten!.uniq!
	stems12.each {|stem| texts12 = texts12 << Word2.where(:stem => stem).first.text }
	


	
	

	client = Selenium::WebDriver::Remote::Http::Default.new
	client.timeout = 800 # seconds – default is 60

	browser = Watir::Browser.new :firefox, :http_client => client
	browser.goto "http://infoweb.newsbank.com.turing.library.northwestern.edu/iw-search/we/InfoWeb?p_product=AWNB&p_action=explore&p_theme=aggregated5&p_nbid=S55L4CLGMTM2ODU1MDIyNy40NDI2NTk6MToxNToxMjkuMTA1LjIxNS4xNDY&p_clear_search=yes&d_refprod=NEWSARCHIVES&f_clearContext=yes"
	# browser.text_field(:name => 'IDToken1').set "abw724"
	# browser.text_field(:name => 'IDToken2').set "@4k5k6k7"
	# browser.button(:name => 'Login.Submit').click
	browser.link(:text => 'North America').click
	browser.link(:text => 'United States').click
	browser.button(:text=> 'Source Types').click
	browser.link(:text => 'Newspapers').click
	url = browser.url



	[825,827,836,841,965,1013,1053,1089,1115,1145,1146,1191,1267,1378,1379,1385,1481,1506,1521,1546,1630,1648,1649,1665,1698,1725,1823,1850,301,310,359,602,637,694,712,735,745,750,792,807].flatten.each {|n|
		row = browser.table[n]

		if row[2].text[6..9].to_i <= 1994 and  row[2].text[17..20] == 't'
			puts(Time::now)
			puts(n)

			
			year = 1994
			link = row[1].link.href
			@paper = Paper.create(:name => row[1].text, :year => year, :state => row[3].text[0..1])
			
			stems94.each{|stem|
				@text = Word.where(:stem => stem).last.text
				browser.goto link
				search =  @text.split[0] +" ADJ1 " + @text.split[1]
				browser.text_field(:name => 'p_text_base-0').set search
				browser.select(:name => 'p_field_base-1').select 'Date'
				browser.text_field(:id => 'searchText-1-dateInput').set '01/01/1994 - 12/31/1994'
				browser.send_keys :enter
				if browser.div(:id=> 'navBreadcrumb').exists? 
					count = browser.div(:id=> 'navBreadcrumb').text.gsub!(/[^0-9]/,'').to_i	
					PaperUse.create(:stem => stem, :paper_id => @paper.id, :frequency => count)
				end
			}

			year = 2012
			browser.goto link

			@paper = Paper2.create(:name => @paper.name, :year => year, :state => @paper.state)
			stems12.each{|stem|
				@text = Word2.where(:stem => stem).last.text
				browser.goto link
				search =  @text.split[0] +" ADJ1 " + @text.split[1]
				browser.text_field(:name => 'p_text_base-0').set search
				browser.select(:name => 'p_field_base-1').select 'Date'
				browser.text_field(:id => 'searchText-1-dateInput').set '01/01/2012 - 12/31/2012'
				browser.send_keys :enter
				if browser.div(:id=> 'navBreadcrumb').exists? 
					count = browser.div(:id=> 'navBreadcrumb').text.gsub!(/[^0-9]/,'').to_i	
					PaperUse2.create(:stem => stem, :paper2_id => @paper.id, :frequency => count)
				end
			}




			browser.goto url
			browser.link(:text => 'Clear All').click
			browser.link(:text => 'North America').click
			browser.link(:text => 'United States').click
			browser.button(:text=> 'Source Types').click
			browser.link(:text => 'Newspapers').click
			puts(Time::now)
		end
		


}



  
end
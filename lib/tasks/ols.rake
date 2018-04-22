require 'rubygems'
require 'watir-webdriver'
require 'pry'

#ADDindextermsfrompublishercriteria


task :ols => :environment do
	words = Hash.new
	stemsS= Word.where('chi2 > 0 and branch = ?','S').order('chi2 DESC').limit(5000).pluck(:stem)
	stemsH = Word.where('chi2 > 0 and branch = ?','H').order('chi2 DESC').limit(5000).pluck(:stem)
	stemsS2= Word2.where('chi2 > 0 and branch = ?','S').order('chi2 DESC').limit(5000).pluck(:stem)
	stemsH2 = Word2.where('chi2 > 0 and branch = ?','H').order('chi2 DESC').limit(5000).pluck(:stem)
	texts = []
	texts2 = []
	
	stems = Word.select('stem, avg(chi2)').where('chi2 > 0 and stem IN (?)', (stemsS & stemsH)).group(:stem).order('avg(chi2) DESC').limit(500).pluck(:stem).uniq
	stems.each {|stem| texts = texts << Word.where(:stem => stem).first.text }

	stems2 = Word2.select('stem, avg(chi2)').where('chi2 > 0 and stem IN (?)', (stemsS2 & stemsH2)).group(:stem).order('avg(chi2) DESC').limit(500).pluck(:stem).uniq
	stems2.each {|stem| texts2 = texts2 << Word2.where(:stem => stem).first.text }
	# texts.sort! {|x,y| x<=> y}
	# texts2.sort! {|x,y| x<=> y}
	puts(texts)
	puts(texts.length)
	puts(texts2)
	puts(texts2.length)
	

	client = Selenium::WebDriver::Remote::Http::Default.new
	client.timeout = 180 # seconds – default is 60

	browser = Watir::Browser.new :firefox, :http_client => client
	browser.goto "http://infoweb.newsbank.com.turing.library.northwestern.edu/iw-search/we/InfoWeb?p_product=AWNB&p_action=explore&p_theme=aggregated5&p_nbid=S55L4CLGMTM2ODU1MDIyNy40NDI2NTk6MToxNToxMjkuMTA1LjIxNS4xNDY&p_clear_search=yes&d_refprod=NEWSARCHIVES&f_clearContext=yes"
	browser.text_field(:name => 'IDToken1').set "abw724"
	browser.text_field(:name => 'IDToken2').set "@4k5k6k7"
	browser.button(:name => 'Login.Submit').click
	browser.link(:text => 'North America').click
	browser.link(:text => 'United States').click
	browser.button(:text=> 'Source Types').click
	browser.link(:text => 'Newspapers').click
	url = browser.url



	[(3075..3080).to_a].flatten.each {|n|
		row = browser.table[n]

		if row[2].text[6..9].to_i <= 1994 and  row[2].text[17..20] == 't'
			puts(Time::now)

			puts(n)	
			year = 1994
			link = row[1].link.href
			@paper = Paper.create(:name => row[1].text, :year => year, :state => row[3].text[0..1])
			
			# stems.each{|stem|
			# 	@text = Word.where(:stem => stem).last.text
			# 	browser.goto link
			# 	search =  @text.split[0] +" ADJ1 " + @text.split[1]
			# 	browser.text_field(:name => 'p_text_base-0').set search
			# 	browser.text_field(:id => 'searchText-2-dateInput').set "Jan #{year} - Dec #{year}"
			# 	browser.button(:text=> 'Search').click	
			# 	if browser.div(:id=> 'navBreadcrumb').exists? 
			# 		count = browser.div(:id=> 'navBreadcrumb').text.gsub!(/[^0-9]/,'').to_i	
			# 		PaperUse.create(:stem => stem, :paper_id => @paper.id, :frequency => count)
			# 	end
			# }

			year = 2012
			@paper = Paper2.create(:name => @paper.name, :year => year, :state => @paper.state)
			stems2.each{|stem|
				@text = Word2.where(:stem => stem).last.text
				browser.goto link
				search =  @text.split[0] +" ADJ1 " + @text.split[1]
				browser.text_field(:name => 'p_text_base-0').set search
				browser.text_field(:id => 'searchText-2-dateInput').set "Jan #{year} - Dec #{year}"
				browser.button(:text=> 'Search').click	
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
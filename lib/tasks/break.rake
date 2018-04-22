require 'rubygems'
require 'watir-webdriver'
require 'pry'
require 'stemmify'


task :break => :environment do
	# RUN THE FOLLOWING TO FIX THE HOUSE/SENATE CLASSIFCATION PROBLEM
	# Person.find_each{|person|
	# 	puts(person.name)
	# 	person.name = person.name.gsub(/ $/,'')
	# 	person.save
	# 	puts(person.name)
	# }

	# RUN THE FOLLOWING TO FIX THE HOUSE/SENATE CLASSIFCATION PROBLEM

	# Person.all.each {|a| 
	# 	a.name = a.name.rstrip
	# 	a.save
	# }


	# Person.where(:party => nil).find_each {|misperson|

	# 	if misperson.branch == 'H'
	# 		@reperson = Person.where(:name => misperson.name, :branch => 'S').first_or_initialize
	# 		if @reperson.party != nil
	# 			puts(@reperson.pages.count)
	# 			@reperson.pages << misperson.pages
	# 			misperson.destroy
	# 			puts(@reperson.pages.count)
	# 		end
	# 	end

	# 	if misperson.branch == 'S'
	# 		@reperson = Person.where(:name => misperson.name, :branch => 'H').first_or_initialize
	# 		if @reperson.party != nil
	# 			puts(@reperson.pages.count)
	# 			@reperson.pages << misperson.pages
	# 			misperson.destroy
	# 			puts(@reperson.pages.count)
	# 		end
	# 	end
	# }


	counter = 0
	Word.find_each {|word|
	counter += 1

	if Word.where(:stem => word.stem).size == 1
		word.delete
	end

	if counter % 10000 == 0
		puts(Time::now)
	end

	



	}
  







end





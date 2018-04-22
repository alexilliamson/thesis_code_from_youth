require 'rubygems'
require 'watir-webdriver'
require 'pry'
require 'stemmify'


task :break2 => :environment do
	# RUN THE FOLLOWING TO FIX THE TRAILING WHITE SPACE  PROBLEM
	# Person2.find_each{|person|
	# 	puts(person.name)
	# 	person.name = person.name.gsub(/ $/,'')
	# 	person.save
	# 	puts(person.name)
	# }

	# Person2.find_each{|person|

	# 	@sames = Person2.where(:score1 => person.score1, :score2 => person.score2).all
	# 	if @sames.size > 1
	# 		puts(person.name)
	# 		(1..(@sames.size - 1)).each {|out|
	# 			@sames[0].page2s << @sames[out].page2s
	# 			puts(@sames[out].name, person.name, 'holla')
	# 			@sames[out].destroy
	# 		}
	# 	end

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
	Word2.find_each {|word|
	counter += 1

	if Word2.where(:stem => word.stem).size == 1
		word.delete
	end

	if counter % 10000 == 0
		puts(Time::now)
	end

	



	}
  







end





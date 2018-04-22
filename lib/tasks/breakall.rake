require 'rubygems'
require 'watir-webdriver'
require 'pry'
require 'stemmify'


task :breakall => :environment do
	# RUN THE FOLLOWING TO FIX THE HOUSE/SENATE CLASSIFCATION PROBLEM
	iters = ["each","minute", "too", "yield","amend","article","asked", "commission", "consider", "colleague", "pargraph", "bill","january", "february", "march","april","may","june","july","august","september","october","november","december","monday","tuesday","wednesday","thursday","friday","saturday","sunday",'insert','agreed','also','appropriat','legislation','concurrent','definition','enact','assemble','purpose','et seq','dakota','carolina','et seq','going','ladies gentleman','new york','adjourn','florida','vote','district','remark',"madam", 'new jersey','rhode island','west virginia','been','support','us','confere','mention','va','more more']
	spefs = ["end", "is", "a",'b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z' 'con','res','st','state','con','res','vote',"further","ranking","aisle","matter"]


	# puts(Word.count, Word2.count)
	# iters.each {|stem|
	# 	Word.where('text like ?', "%#{stem}%").delete_all
	# 	Word2.where('text like ?', "%#{stem}%").delete_all
	# }


	spefs.each {|stem|
		Word.where('text like ?', "#{stem} %").delete_all
		Word.where('text like ?', "% #{stem}").delete_all
		Word2.where('text like ?', "#{stem} %").delete_all
		Word2.where('text like ?', "% #{stem}").delete_all
	}



	puts(Word.count, Word2.count)

end





require 'rubygems'
require 'watir-webdriver'
require 'pry'
require 'stemmify'


task :break => :environment do
	counter = 0
	array = ["legislative","objection", "iask", "senate", "senator", "senators", "gentleman","recess", "representative", "session", "committee" , "unanimous", "consent", "presiding", "object", "iwithdrawreserve", "tempore", "clerk", "presiding", "meetsessione", "revisextende", "proceed", "withdraw","chair"]
	words = []
	array.each {|thing| words = words << thing.stem}
	Phrase.find_each {|phrase|
		words.each {|word|
			if phrase.stem.include? word
				phrase.uses.destroy_all
				phrase.destroy
			end
		}

		counter =+ 1

		if counter % 10000 == 0
			puts(counter)
		end
		}
end
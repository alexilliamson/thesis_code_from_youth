require 'rubygems'
require 'watir-webdriver'
require 'csv'


task :printpaper => :environment do

	texts94 = []
	words = Hash.new
	dim1S94= Word.where('chi2 > 0 and branch = ?','S').order('chi2 DESC').limit(5000).pluck(:stem)
	dim1H94 = Word.where('chi2 > 0 and branch = ?','H').order('chi2 DESC').limit(5000).pluck(:stem)
	dim2S94= Word.where('chib > 0 and branch = ?','S').order('chib DESC').limit(5000).pluck(:stem)
	dim2H94= Word.where('chib > 0 and branch = ?','H').order('chib DESC').limit(5000).pluck(:stem)
	stems194 = Word.select('stem, avg(chi2)').where('chi2 > 0 and stem IN (?)', (dim1S94 & dim1H94)).group(:stem).order('avg(chi2) DESC').limit(350).pluck(:stem).uniq
	stems294 = Word.select('stem, avg(chib)').where('chib > 0 and stem IN (?)', (dim2S94 & dim2H94)).group(:stem).order('avg(chib) DESC').limit(150).pluck(:stem).uniq
	stems94 = stems194 << stems294
	stems94.flatten!.uniq!
	stems94.each {|stem| texts94 = texts94 << Word.where(:stem => stem).last.text }


	CSV.open("paper_freq.csv", "wb") do |csv|
		data = ['Name', 'State', 'ID','Year']
		texts94.each {|word| data = data << word}
		csv << data

		Paper.all.each {|paper|
		@total = paper.paper_uses.sum(:frequency).to_f
		data = [paper.name, paper.state, paper.id, paper.year]
		stems94.each {|stem| 
			occ = paper.paper_uses.where(:stem => stem).sum(:frequency).to_f
			data = data << (occ/@total)
		}
		csv << data
		puts("#{data}")
		}
	end


	texts12 = []
	dim1S12= Word2.where('chi2 > 0 and branch = ?','S').order('chi2 DESC').limit(5000).pluck(:stem)
	dim1H12= Word2.where('chi2 > 0 and branch = ?','H').order('chi2 DESC').limit(5000).pluck(:stem)
	dim2S12= Word2.where('chib > 0 and branch = ?','S').order('chib DESC').limit(5000).pluck(:stem)
	dim2H12= Word2.where('chib > 0 and branch = ?','H').order('chib DESC').limit(5000).pluck(:stem)	
	stems112 = Word2.select('stem, avg(chi2)').where('chi2 > 0 and stem IN (?)', (dim1S12 & dim1H12)).group(:stem).order('avg(chi2) DESC').limit(350).pluck(:stem).uniq
	stems212 = Word2.select('stem, avg(chib)').where('chib > 0 and stem IN (?)', (dim2S12 & dim2H12)).group(:stem).order('avg(chib) DESC').limit(150).pluck(:stem).uniq
	stems12 = stems112 << stems212
	stems12.flatten!.uniq!
	stems12.each {|stem| texts12 = texts12 << Word2.where(:stem => stem).last.text }
	



	CSV.open("paper_freq2.csv", "wb") do |csv|
		data = ['Name', 'State', 'ID','Year']
		texts12.each {|word| data = data << word}
		csv << data

		Paper2.all.each {|paper|
		@total = paper.paper_use2s.sum(:frequency).to_f
		data = [paper.name, paper.state, paper.id, paper.year]
		stems12.each {|stem| 
			occ = paper.paper_use2s.where(:stem => stem).sum(:frequency).to_f
			data = data << (occ/@total)
		}
		csv << data
		puts("#{data}")
		}
	end


  
end
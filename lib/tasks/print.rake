require 'rubygems'
require 'watir-webdriver'
require'stemmify'
require 'csv'


task :print => :environment do
# Print phrase counts
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

# 	CSV.open("phrase_count.csv", "wb") do |csv|
# 		csv << ['Year','Phrase','R','D','T']
	

# 		texts94.each_index {|a| 
# 			t = Word.joins(:pages).where('words.stem = ?', stems94[a]).group('pages.id,words.id').length
# 			r = Word.joins(:people).where('words.stem = ? and people.party = ?', stems94[a], 'R').group('pages.id,words.id').length
# 			d = Word.joins(:people).where('words.stem = ? and people.party = ?', stems94[a], 'D').group('pages.id,words.id').length
# 			csv << ['1994', "#{texts94[a]}", r, d, t]
# 		} 

# 		texts12.each_index {|a| 
# 			t = Word2.joins(:page2s).where('word2s.stem = ?', stems12[a]).group('page2s.id,word2s.id').length
# 			r = Word2.joins(:person2s).where('word2s.stem = ? and person2s.party = ?', stems12[a], 'R').group('page2s.id,word2s.id').length
# 			d = Word2.joins(:person2s).where('word2s.stem = ? and person2s.party = ?', stems12[a],'D').group('page2s.id,word2s.id').length
# 			csv << ['2012', "#{texts12[a]}", r, d, t]
# 		} 

# end




# Print speaker stats

	CSV.open("speaker_freq.csv", "wb") do |csv|
		data = ["name", "branch", "party", "score1","score2"]

		texts94.each {|word| data = data << word}
		csv << data


		Person.all.each {|person|

			@total = Page.where(:person_id => person.id).joins(:words).where('words.stem in (?)', stems94 ).group('pages.id,words.id').length.to_f
			data = [person.name, person.branch, person.party, person.score1, person.score2]
			puts(data)
			stems94.each {|stem|
				occ = Page.where(:person_id => person.id).joins(:words).where('words.stem = (?)', stem).group('pages.id,words.id').length.to_f
				if @total > 0
					occ = occ/@total
				end

				if occ == 0.to_f 
					occ = 0.0
				end


				data = data << occ
			}
			puts("#{data}")
			csv << data
		}
	end


CSV.open("speaker_freq2.csv", "wb") do |csv|
	data = ["name", "branch", "party", "score1","score2"]
		texts12.each {|word| data = data << word}
		csv << data

		Person2.all.each {|person|
			@total = Page2.where(:person2_id => person.id).joins(:word2s).where('word2s.stem in (?)', stems12 ).group('page2s.id,word2s.id').length.to_f
			data = [person.name, person.branch, person.party, person.score1, person.score2]
			puts(data)
			stems12.each {|stem|
				occ = Page2.where(:person2_id => person.id).joins(:word2s).where('word2s.stem = (?)', stem).group('page2s.id,word2s.id').length.to_f
				if @total > 0
					occ = occ/@total
				end

				if occ == 0.to_f 
					occ = 0.0
				end


				data = data << occ
			}
			puts("#{data}")
			csv << data
		}

	end





  
end
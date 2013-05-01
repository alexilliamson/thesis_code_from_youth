require 'rubygems'
require 'stemmify'
require 'pry'

task :phrase_assign => :environment do
(1994..2012).each {|year|
  Use.where('use.passage.speaker.year => 2012')
}
  texts = Phrase.uniq.pluck(:text).size
  puts(texts)

  Phrase.find_each(:include => :occurences) {|phrase|
      fpr = phrase.occurences.where(:speaker_id => (Speaker.select(:id).where(:year => year,:party => 'R'))).count.to_f
      fpd = phrase.occurences.where(:speaker_id => (Speaker.select(:id).where(:year => year, :party => 'D'))).count.to_f
      fnpr = rtotal - fpr
      fnpd = dtotal - fpd
      chi2 = ((fpr*fnpd - fpd*fnpr)**2)/((fpr+fpd)*(fpr+fnpr)*(fpd+fnpd)*(fnpr+fnpd)).to_f
      phrase.assign_attributes(:chi2 => chi2)
      phrase.save
      puts(phrase.id)
  }


    
end

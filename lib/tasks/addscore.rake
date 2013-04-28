require 'rubygems'
require 'stemmify'
require 'pry'

task :addscore => :environment do

  year = 2012
  counts = Speaker.find_by_sql(["select count(speaker_id) as number, s.party from speakers s 
  inner join passages p on s.id = p.speaker_id 
  inner join phrases ph on ph.passage_id = p.id 
  where s.year =?
  group by s.party", year])
  rtotal = counts.select {|a| a.party == 'R'}
  dtotal = counts.select {|a| a.party == 'D'}
  rtotal = rtotal[0].number.to_f
  dtotal = dtotal[0].number.to_f
  Phrase.select[:text].uniq

  Phrase.find_by_sql(["select d.number, r.number, r.text from
  (select count(p.speaker_id) as number, s.party, p.text from speakers s 
  inner join passages p on s.id = p.speaker_id 
  inner join phrases ph on ph.passage_id = p.id 
  where s.year =? and s.party = 'D'
  group by p.text, s.party)d full outer join
  (select count(p.speaker_id) as number, s.party, p.text from speakers s 
  inner join passages p on s.id = p.speaker_id 
  inner join phrases ph on ph.passage_id = p.id 
  where s.year =? and s.party = 'R'
  group by p.text, s.party)r on d.text=r.text", year]).each {|row| 

  }
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

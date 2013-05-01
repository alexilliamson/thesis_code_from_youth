require 'rubygems'
require 'stemmify'
require 'pry'

task :addscore => :environment do

  year = 2012
  rtotal = Use.joins(:passage => :speaker).where(:speakers => {:party =>'R'} , :speakers => {:year => year}).count.to_f
  dtotal = Use.joins(:passage => :speaker).where(:speakers => {:party =>'R'} , :speakers => {:year => year}).count.to_f
  puts(rtotal)
  puts(dtotal)

 

  Phrase.find_each {|phrase|
    fr = Use.joins(:passage => :speaker).where(:speakers => {:party =>'R'}, :uses => {:phrase_id => phrase.id}).count.to_f
    fd = Use.where(:phrase_id => phrase.id).count.to_f - fr
    nfr = rtotal - fr
    nfd = dtotal - fd
    chi2 = ((fr*nfd - fd*nfr)**2)/((fr+fd)*(fr+nfr)*(fd+nfd)*(nfr+nfd)).to_f
    phrase.assign_attributes(:chi2 => chi2)
    if phrase.id % 10000 == 0
      puts(phrase.id)
    end
  }


    
end

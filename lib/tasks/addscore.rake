require 'rubygems'
require 'stemmify'
require 'pry'

task :addscore => :environment do
  puts(Time::now)
  [1994,2012].each {|year|

  @rtotal = Phrase.joins(:passages => :speaker).where(:speakers => {:party =>'R', :year => year} ).uniq.count.to_f
  @dtotal = Phrase.joins(:passages => :speaker).where(:speakers => {:party =>'D', :year => year} ).uniq.count.to_f
  puts(@rtotal)
  puts(@dtotal)

 


  Phrase.find_each {|phrase|
    @fr = phrase.passages.all.uniq.count {|p| p.speaker.party == 'R'}
    @fd = phrase.passages.all.uniq.count - @fr
    @nfr = @rtotal - @fr
    @nfd = @dtotal - @fd
    @chi2 = ((@fr*@nfd - @fd*@nfr)**2)/((@fr+@fd)*(@fr+@nfr)*(@fd+@nfd)*(@nfr+@nfd)).to_f
    phrase.assign_attributes(:chi2 => @chi2)
    phrase.save

    if phrase.id % 10000 == 0
      puts (phrase.id)
    end
  }
  }
  puts(Time::now)


    
end

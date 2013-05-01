require 'rubygems'
require 'stemmify'
require 'pry'

task :build_phrase => :environment do
  year = 2012
  Use.joins(:passage => :speaker).where('speakers.year = ?', year).find_each(:readonly => false) {|use|
    @phrase = use.text.split[0].stem + use.text.split[1].stem + use.text.split[2].stem
    @new = Phrase.find_or_create_by_stem_and_year(:stem => @phrase, :year => year)
    use.phrase = @new
    use.save
    if use.id % 10000 == 0
      puts(use.id)
    end
  }


    
end

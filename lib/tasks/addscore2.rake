require 'rubygems'
require 'stemmify'
require 'pry'

task :addscore2 => :environment do
  counter = 0
  # branch = 'H'

  #   @rids = Person.righthb.pluck(:id)
  #   @lids = Person.lefthb.pluck(:id)
  #   @rtotal = Page.where(:person_id => @rids).joins(:words).count(:group => 'pages.id,words.id').length.to_f
  #   @ltotal =Page.where(:person_id => @lids).joins(:words).count(:group => 'pages.id,words.id').length.to_f
  #   Total = @rtotal + @ltotal 
  #   rshare = @rtotal/Total
  #   lshare = @ltotal/Total
      
  #   puts(@rtotal)
  #   puts(@ltotal)


  #   Word.where(:branch => branch).find_each {|word|
  #     @ofl = word.pages.where(:person_id => @lids).pluck(:id).count.to_f
  #     @ofr = word.pages.where(:person_id => @rids).pluck(:id).count.to_f
  #     sum = @ofl +  @ofr
  #     exl = sum * lshare
  #     exr = sum * rshare
      
  #     if exl > 0 

  #       @chi2 = ((@ofl - exl)**2)/exl + ((@ofr - exr)**2)/exr


  #       word.assign_attributes(:chib => @chi2)
  #       word.save
  #       counter += 1


  #       if counter % 10000 == 0
  #         puts(Time::now)
  #         puts (counter)
  #       end
  #     end

  # }

  branch = 'S'

    @rids = Person.rightsb.pluck(:id)
    @lids = Person.leftsb.pluck(:id)
    @rtotal =Page.where(:person_id => @rids).joins(:words).count(:group => 'pages.id,words.id').length.to_f
    @ltotal =Page.where(:person_id => @lids).joins(:words).count(:group => 'pages.id,words.id').length.to_f
    Total = @rtotal + @ltotal 
    rshare = @rtotal/Total
    lshare = @ltotal/Total
      
    puts(@rtotal)
    puts(@ltotal)


    Word.where(:branch => branch).find_each {|word|
      @ofl = word.pages.where(:person_id => @lids).pluck(:id).count.to_f
      @ofr = word.pages.where(:person_id => @rids).pluck(:id).count.to_f
      sum = @ofl +  @ofr
      exl = sum * lshare
      exr = sum * rshare
      
      if exl > 0 

        @chi2 = ((@ofl - exl)**2)/exl + ((@ofr - exr)**2)/exr


        word.assign_attributes(:chib => @chi2)
        word.save
        counter += 1


        if counter % 10000 == 0
          puts(Time::now)
          puts (counter)
        end
      end

  }




  




  puts(Time::now)



    
end

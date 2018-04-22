require 'rubygems'
require 'stemmify'
require 'pry'

task :addscore => :environment do
  counter = 0
  branch = 'H'

    @rids = Person2.righthb.pluck(:id)
    @lids = Person2.lefthb.pluck(:id)
    @rtotal = Page2.where(:person2_id => @rids).joins(:word2s).count(:group => 'page2s.id,word2s.id').length.to_f
    @ltotal =Page2.where(:person2_id => @lids).joins(:word2s).count(:group => 'page2s.id,word2s.id').length.to_f
    Total = @rtotal + @ltotal 
    rshare = @rtotal/Total
    lshare = @ltotal/Total
      
    puts(@rtotal)
    puts(@ltotal)


    Word2.where(:branch => branch).find_each {|word|
      @ofl = word.page2s.where(:person2_id => @lids).pluck(:id).count.to_f
      @ofr = word.page2s.where(:person2_id => @rids).pluck(:id).count.to_f
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

  branch = 'S'

    @rids = Person2.rightsb.pluck(:id)
    @lids = Person2.leftsb.pluck(:id)
    @rtotal =Page2.where(:person2_id => @rids).joins(:word2s).count(:group => 'page2s.id,word2s.id').length.to_f
    @ltotal =Page2.where(:person2_id => @lids).joins(:word2s).count(:group => 'page2s.id,word2s.id').length.to_f
    Total = @rtotal + @ltotal 
    rshare = @rtotal/Total
    lshare = @ltotal/Total
      
    puts(@rtotal)
    puts(@ltotal)


    Word2.where(:branch => branch).find_each {|word|
      @ofl = word.page2s.where(:person2_id => @lids).pluck(:id).count.to_f
      @ofr = word.page2s.where(:person2_id => @rids).pluck(:id).count.to_f
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

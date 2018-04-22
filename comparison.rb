require 'stemmify'

timeswords = []
postwords = []

File.new("times_article.txt","r+").each_line{|line|
  	line.gsub!(/[^A-Za-z ]/,'').downcase!
  	line.split.each{ |word| timeswords << word}
  }

timeswords = timeswords.first(50).map{|a| a.stem}
timeswords.uniq!

File.new("post_article.txt","r+").each_line{|line|
  	line.gsub!(/[^A-Za-z ]/,'').downcase!
  	line.split.each{ |word| postwords << word}
  }
postwords = postwords.first(50).map{|a| a.stem}
postwords.uniq!


postwords.select! {|a| !(timeswords.include? (a)) and a.length > 4}
timeswords.select! {|a| !(postwords.include? (a)) and a.length > 4}

postwords.sort! {|a,b| b <=> a}
timeswords.sort! {|a,b| b <=> a}
puts("PSOTTTTT")
puts (postwords)
puts("\n\n\nTIMEEEEEEEEEEEEEE")
puts(timeswords)
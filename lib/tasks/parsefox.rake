require 'rubygems'
require 'stemmify'
require 'pry'

task :parsefox => :environment do
  Word.destroy_all
  $stopwords = ["unanimous consent","extend","member","revise", "members" , "pro tempore", "use later in the day","mr. president" "completes business", "business today", "resume","legislative","objection", "i ask", "senate", "senator", "senators", "gentleman","recess", "representative", "session", "committee" , "unanimous", "presiding", "officer", "object", "tempore", "clerk", "presiding", "meetsessione", "revisextende", "proceed", "withdraw","chair","committee" ,"i","presiding officer","rollcall", "yield","mr", "united", "states", "congressional", "congress", "a", "dear", "speaker", "about", "above", "across", "after", "afterwards", "again", "against", "all", "almost", "alone", "along", "already", "also","although","always","am","among", "amongst", "amoungst", "amount",  "an", "and", "another", "any","anyhow","anyone","anything","anyway", "anywhere", "are", "around", "as",  "at", "back","be","became", "because","become","becomes", "becoming", "been", "before", "beforehand", "behind", "being", "below", "beside", "besides", "between", "beyond", "bill", "both", "bottom","but", "by", "call", "can", "cannot", "cant", "co", "con", "could", "couldnt", "cry", "de", "describe", "detail", "do", "done", "down", "due", "during", "each", "eg", "eight", "either", "eleven","else", "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone", "everything", "everywhere", "except", "few", "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly", "forty", "found", "four", "from", "front", "full", "further", "get", "give", "go", "had", "has", "hasnt", "have", "he", "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his", "how", "however", "hundred", "ie", "if", "in", "inc", "indeed", "interest", "into", "is", "it", "its", "itself", "keep", "last", "latter", "latterly", "least", "less", "ltd", "made", "many", "may", "me", "meanwhile", "might", "mill", "mine", "more", "moreover", "mostly", "move", "much", "must", "my", "myself", "name", "namely", "neither", "never", "nevertheless", "next", "nine", "no", "nobody", "none", "noone", "nor", "not", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto", "or", "other", "others", "otherwise", "over", "part", "per", "perhaps", "please", "put", "rather", "re", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she", "should", "show", "side", "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something", "sometime", "sometimes", "somewhere", "still", "such", "take", "ten", "than", "that", "the", "their", "them", "then", "thence", "there", "thereafter", "thereby", "therefore", "therein", "thereupon", "these", "they", "thickv", "third", "this", "those", "though", "three", "through", "throughout", "thru", "thus", "to", "too", "top", "toward", "towards", "twelve", "twenty", "two", "un", "under", "until", "up", "upon", "us", "very", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever", "where", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "who", "whoever", "whole", "whom", "whose", "why", "will", "with", "within", "without", "would", "yet", "you", "your", "yours", "yourself", "yourselves", "the"]
  $killwords = ["following the prayer","journal of proceedings"]
        puts(Time::now)
        Page.includes(:person).find_each { |page|
          if page.id % 100 == 0
            puts(page.id)
          end
          kill = false
          text = page.text.downcase
          year = page.person.year
          branch = page.person.branch

          $killwords.each {|w|
            if text.include? (w)
              kill = true
              puts(text)
              break
            end
          } 

          if kill == false
            words = []
            parse = page.text.downcase
            parse.gsub!(/[^a-z] /, ' ')
            parse.gsub!(/ . /, ' ')
            $stopwords.each {|x| parse.gsub!(" #{x} ", " ")}
            parse = parse.split
            (0..(parse.length-2)).each {|b| 
              words = parse[b] + ' ' + parse[b+1]
              stem = parse[b].stem + ' ' + parse[b+1].stem
              @word = Word.where(:stem => stem, :year => year, :branch => branch).first_or_create(:text => words)
              page.words << @word
            }
            end 

          if kill == true
            page.destroy
          end

        }
      puts(Time::now)

    
end


require 'rubygems'
require 'stemmify'
require 'pry'

task :parse2 => :environment do

  $stopwords = ["testimony","read","today","friends","friend","given permission","reserved","reserve","majority","minority","leader","balance", "federal debt","per capita","every man","affairs","authorize","authorized","testimony","stood","absence","order","because of illness","before","first", "man woman child","america owes","reserving the right","appears","statement","statements","morning business","action","per","read","business to come", "activity","activities", "after","budget", "insert","inserted","does","include", "follows","following","follow","followed","any","these", "reconsider","purpose","percent","hereby", "established","appropirated","appropriations","ii","iii","includes","extent","detail","details","ought","put back","forth","sincerely","dear","subdivision","technical","thank","total", "establish", "record" "enactment","enacted", "equally divided","divided","our","we","am","friend","report","submit","said","votes","vote","please","thank you","hearing","hearings","session", "sessions", "lieu","debate", "semicolon", "chairman","comments","through","table","contents","precede","preceding","later","tomorrow","tuesday", "en bloc","myself","pending","was","request","clause","reform","modified","modify","due","add","procedure","procedures","accordance","chairman","provision", "table en","quorum","absence","previously","stand","stood","record","read","order","ordered", "speaker","shall","has", "adding","vote","its", "consider","under", "section","paragraph","subsection","act","resolution","recognize","colleague","should","clinton", "such","days","day","except","period", "secretary","title","act sec","chairman","date", "ask","may","absent","remark","title","assemebled","assemble" "is","amendment","upon","statement","nays","yeas","vote","representative", "are","upon","rule","follow", "motion","suspend", "president","leadership","speaker","house","pursuant","meet","bill" "distinguished", "close of business","immediate consideration", "unanimous consent","extend","member","revise", "members" , "pro tempore", "use later in the day","mr. president" "completes business", "business today", "resume","legislative","objection", "i ask", "senate", "senator", "senators", "gentleman","recess", "representative", "session", "committee" , "unanimous", "consent", "presiding", "object", "tempore", "clerk", "presiding", "meet session", "proceed", "withdraw","chair","committee" ,"i", "unanimous consent","presiding Officer","rollcall", "yield","mr", "united", "states", "congressional", "congress", "the","meet during", "we", "house","yet","reject","administration",
"be",
"to",
"of",
"and",
"a",
"in",
"that",
"have",
"i",
"it",
"for",
"not",
"on",
"with",
"he",
"as",
"you",
"do",
"at",
"this",
"but",
"his",
"by",
"from",
"they",
"we",
"say",
"her",
"she",
"or",
"an",
"will",
"my",
"one",
"all",
"would",
"there",
"their",
"what",
"so",
"up",
"out",
"if",
"about",
"who",
"get",
"which",
"go",
"me",
"when",
"make",
"can",
"like",
"time",
"no",
"just",
"him",
"know",
"take",
"people",
"into",
"year",
"your",
"good",
"some",
"could",
"them",
"see",
"other",
"than",
"then",
"now",
"look",
"only"]

  $killwords = ["following the prayer","journal of proceedings","house adjourns today", "[roll call no]"]
        puts(Time::now)
        counter = 0

        Page2.includes(:person2).find_each(:start => 37618 )  { |page|
          counter += 1
          if counter % 100 == 0
            puts(page.id)
            puts(Time::now)
          end

          kill = false

          text = page.text.downcase
          $killwords.each {|w|
            if text.include? (w)
              kill = true
              puts("AHAHAHA #{w}")
              puts(text)
              break
            end
          } 
          @page = page
          if kill == false
            
            branch = page.person2.branch
            words = []
            parse = text
            parse.gsub!(/[^a-z ]/, ' ')
            parse.gsub!(/ . /, ' ')
            $stopwords.each {|x| parse.gsub!(" #{x} ", " ")}
            parse = parse.split
            (0..(parse.length-2)).each {|b| 
              stem = parse[b].stem + ' ' + parse[b+1].stem
              @page.word2s << Word2.where(:stem => stem, :branch => branch).first_or_create(:text => (parse[b] + ' ' + parse[b+1]))
            }
            end 

          if kill == true
            page.destroy
          end

        }
      puts(Time::now)

    
end


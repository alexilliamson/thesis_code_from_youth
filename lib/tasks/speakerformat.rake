require 'rubygems'
require 'watir-webdriver'
require 'pry'
require 'CSV'
#rename
task :speakerformat => :environment do
  info = []
  CSV.foreach("DWcommonspace.csv") {|line| 
    info = info << line
  }
  puts(info.size)
  info.each_index {|n|
    info[n][3] = info[n][3].split[0]
    case info[n][2]
    when '100'
      info[n][2] = 'D'
    else
      info[n][2] = 'R'
    end
    case 
    when info[n][5].to_i > 0
      info[n][5] = 'House'
    else
      info[n][5] = 'Senate'
    end
  }

# identify doubles
  info.each {|line| 
    test = info.count {|person| (person[3] == line[3] && person[0] == line[0]) && (person[5] == line[5])}
    if test > 1
      name = line[3]
      congress = line[0]
      info.each_index {|personindex| 
        if (info[personindex][3] == name  && info[personindex][0] == congress) && (info[personindex][5] == line[5])
          info[personindex][3] = info[personindex][3] + ' OF ' + info[personindex][1].upcase
        end
      }
    end
  }


  output = File.new("speakerinfo.txt","r+")
  info.each {|line| 
    output.puts("#{line[3]},#{(line[0].to_i-103)*2 + 1994},#{line[2]},#{line[4]},#{line[5]},#{line[6]}")
    output.puts("#{line[3]},#{(line[0].to_i-103)*2 + 1993},#{line[2]},#{line[4]},#{line[5]},#{line[6]}")
    output.puts("#{line[3]} OF #{line[1].upcase},#{(line[0].to_i-103)*2 + 1994},#{line[2]},#{line[4]},#{line[5]},#{line[6]}")
    output.puts("#{line[3]} OF #{line[1].upcase},#{(line[0].to_i-103)*2 + 1993},#{line[2]},#{line[4]},#{line[5]},#{line[6]}")

  }
  output.close

end
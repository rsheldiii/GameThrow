require './parser.rb'
require './court.rb'

#this is the enclosure for the more pure game, player, and team classes, that prompts for input and checks them against the parser
class Game
 	def initialize()
		court = Court.new()
		court.startingLineup()
		court.start()
	end



 	def startingLineup()
	    begin
	      puts "enter the starting lineup for the home team separated by commas"
	      temp = ['1','2','3','4','5']#gets.chomp.scan(/[^,]+/)
	      bool = court.home.reset(temp,false)
	    end while bool == false
	    
	    begin
	      puts "enter the starting lineup for the away team separated by commas"
	      temp = ['6','7','8','9','10']#gets.chomp.scan(/[^,]+/)	
	      bool = court.away.reset(temp,false)
	    end while bool == false
 	end

	def start()
	    while @possession.possession != "Home" and @possession.possession != "Away"
	      puts @possession.possession
	      puts "possession: home or away? clock starts after entry"
	      @possession.set(gets[0,4])
	    end
	    startClock(nil)
	    puts "clock started, game commence"
	  #start the game
	    while line = gets
	      callParse(line)
	    end
	end

	def callParse(line)
		matchdata = @parser.parse(line)#prepend u after all whitespace is removed just in case
		if matchdata == nil
		  puts "no match found, try again" 
		  
		else  
		  if matchdata["regexp"].names.include?("undo") == true
		    undo = matchdata["regexp"]["undo"] == 'u'? true:false
		  end
		   undoable =  send(matchdata["function"],regex.new(@possession.possession, matchdata["regexp"], undo))
		end
		@cmdStack = line if undoable == true
	end

  #this section contains regex functions. these all filter back through the object map until they do all they are supposed to do


  def shot(regex)
    court.shot(regex);
  end


  def printPlayer(regex)
    puts court.findPlayer(regex)
  end

  def resetPossession(regex)
    court.resetPossession(regex)#these are all repeats. could we perhaps do method_missing?
  end

  def undo(regex)
    cmd = @cmdStack.pop.gsub(/^u*/,'')#if we already negated this string, kill the u so we can add it again naively
    cmd = 'u'+cmd.lstrip
    callParse(cmd) if cmd != "u"
  end

  def turnover(regex)
  	court.turnover(regex)
  end

  def OB(regex)
  	court.OB()
  end
end
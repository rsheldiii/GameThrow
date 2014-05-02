require './parser.rb'
require './court.rb'
require './player.rb'

#this is the enclosure for the more pure game, player, and team classes, that prompts for input and checks them against the parser
class Game
 	def initialize()
 		@cmdStack = []
 		@commandList = {
 			#TODO: add commands here and relate them to the top level function they fire off
 		}
		home,away = createTeams()
		@court = Court.new(home,away)
		@parser = Parser.new()

		startingLineup()
		tipoff()
		play()
	end


	#team creation block
	def createTeams()
		puts "creating home team"
		home = createTeam()
		puts "creating away team"
		away = createTeam()
		[home,away]
	end

	def createTeam()
		team = []
		while true do
			a = createPlayer()
			break if !a
			team << a
		end
		Team.new(team)
	end

	def createPlayer()
		puts "enter player number or enter to escape"
		num = gets.chomp
		return false if num.length == 0
		puts "enter player name"
		name = gets.chomp
		Player.new(num,name)
	end



 	def startingLineup()
 		puts "enter the starting lineup numbers for the home team"
 		h = @court.home.reset((1..5).collect{|x| gets.chomp},@court.clock?) until h
  		puts "enter the starting lineup numbers for the away team"
 		a = @court.away.reset((1..5).collect{|x| gets.chomp},@court.clock?) until a
 	end


	def play()
	    while line = gets
	      callParse(line)
	    end
	end

	def callParse(line)
		matchdata = @parser.parse(line)
		if matchdata == nil
		  puts "unrecognized command. h for help" 
		else  
		   send(matchdata["function"],matchdata["regexp"])
		end
		@cmdStack << line
	end

  #this section contains regex functions. these all filter back through the object map until they do all they are supposed to do

	def tipoff()
	    @court.tipoff()
	end

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

  def help(regex)
  	@parser.keywordMap.each {|command| puts command.command + ":" + command.help + "\n" + command}
  end
end



a = Game.new()
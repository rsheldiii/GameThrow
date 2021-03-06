#TODO: get refamiliarized with this code.
#I really need a firm design for the direction of this program. I need to enumerate a feature set and code that feature set into a program

require './player.rb'
require './team.rb'
require './possession.rb'

class Court

	attr_reader :clock,
				:home,
				:away,
				:possession

  def initialize(home,away)
    @cmdStack = []

    @parser = Parser.new()

    @home = home
    @away = away

    @possession = Possession.new()

    @clock = false
  end

  def to_s
    "Home team: " + @home.to_s + "\nAway team: " + @away.to_s
  end


  def clock?
  	@clock
  end


  #regex functions

  def stopClock(regex)
    if @clock
      puts "stopping clock"
      @home.stopClock()
      @away.stopClock()
    else
      puts "clock is not currently runing" 
    end
  end

  def startClock(regex)
    if !@clock
      puts "starting clock"
      @home.startClock()
      @away.startClock()
    else
      puts "clock is currently running"
    end
  end

  def findPlayer(regex)
    return @home.findPlayer(regex) if @possession.possession == :Home#dunno if this is the best way to do this
    return @away.findPlayer(regex) if @possession.possession == :Away
  end

  def shot(regex)
    @home.shot(regex) if @possession.possession == :Home
    @away.shot(regex) if @possession.possession == :Away

    if regex['sunk'] == 's'
      @possession.switch()
    end
  end

  def resetPossession
    possession = regex['possession']
    if regex['undo'] != 'u'
      @possession.set(possession)
    else
      @possession.opposite(possession)
    end
  end

  def turnover
    @possession.switch()
  end

  def OB
    stopClock()
    turnover()
  end

  def tipoff()
	while !@possession.possession
	    puts "tipoff possession: [h]ome or [a]way?"
	    @possession.set(gets[0])
	end
	startClock(nil)
	puts "clock started"
  end


end

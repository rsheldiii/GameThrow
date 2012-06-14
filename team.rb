require './player.rb'

class Team
  attr_reader :teamRebounds, :turnOvers
  public
  def initialize(players)
    @teamRebounds, @turnOvers = 0
    @players = {}
    @playersOnCourt = []
      players.each do |player|
        @players[player.number] = player
      end
    self
  end


  def switchPlayer(goingIn, goingOut)
    self.addPlayer(goingIn)
    self.remPlayer(goingOut)
  end

  public
  #TODO: put a provision in game to tell when a clock is turned on. if it is not, pass false to the boolean in these functions
  #players should never be added when the clock is on. however, if this is so, this boolean will cover it. Otherwise, the clock should be turned on when play resumes, automatically turning on each players clock
  def addPlayer(goingIn, isClockOn)
    @playersOnCourt.push(goingIn)
    goingIn.starttime() if isClockOn
  end

  def remPlayer(goingOut, isClockOn)#to match form, doesn't hurt if clock is already off
    @playersOnCourt.remove(goingOut, isClockOn)
    goingOut.stoptime()
  end

  def reset(numbers,isClockOn)
    puts numbers.length
    bool = true
    numbers.each do |number|
      if @players[number] == nil
        bool = false 
        puts number.to_s + "is not in there"
      end
    end
    puts bool
    if numbers.length == 5 and bool != false
      @playersOnCourt.each do |player|
        self.remPlayer(player)
      end
      @playersOnCourt = []
    
      numbers.each do |number|
        self.addPlayer(@players[number],isClockOn)
      end
      return true
    else puts "not 5 players, try again"
    return false
    end
  end
  
  def to_s
    out = ""
    @players.each do |number,player|

      out += player.to_s + "; "
    end
    return out[0,out.length-2]
  end

  def findPlayer(number)
    @players[number]
  end

  def stopClock()
    @playersOnCourt.each do |player|
      player.stopTime()
    end
  end

  def startClock()
    @playersOnCourt.each do |player|
      player.startTime()
    end
  end

  
end


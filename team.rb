require './player.rb'

class Team
  attr_reader :teamRebounds, :turnOvers

  def initialize(players)
    #expects player array
    @teamRebounds, @turnOvers = 0

    @players = {}
    players.each do |player|
      @players[player.number] = player
    end 

    @playersOnCourt = []
  end


  def switchPlayer(goingIn, goingOut, isClockOn)#what's nice is with the new classmap model, court can feed isClockOn to all these functions instead of having it be a global kinda thing
    self.addPlayer(@players[goingIn],isClockOn)

    @playersOnCourt.remove(@players[goingOut])
    goingOut.stoptime()
  end

  def addPlayer(goingIn, isClockOn)#addplayer allows us to take care of the edge case of starting with no 
    if @playersOnCourt.size <5
      @playersOnCourt.push(goingIn)
      goingIn.starttime() if isClockOn
    else
      puts "max size reached, please swap players. team:" + self
  end

  def reset(numbers,isClockOn)
    numbers.each do |number|
      if @players[number] == nil 
        puts number.to_s + "is not in there"
        return false
      end
    end

    if numbers.length == 5#@playersOnCourt.length == 5 is assumed
      @playersOnCourt.each do |player|
        player.stopTime()#switchplayer would be nice here but we are mutating the list. check back to see if it's possible later TODO
      end
      @playersOnCourt = []
    
      numbers.each do |number|
        self.addPlayer(@players[number],isClockOn)
      end
      return true
    else 
      puts "incorrect number of players on court. please try again"
      return false
    end
  end
  
  def to_s
    out = ""
    @players.each do |number,player|

      out += player.to_s + "; "
    end
    return out.chomp('; ')
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






  #regex functions


  def shot(regex)
    findPlayer(regex['number']).shot(regex)
  end

  
end


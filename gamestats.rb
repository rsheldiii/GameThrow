class Player
  attr_reader :number, :name, :personalFouls, :technicalFouls, :freeThrows, :freeThrowAttempts, :threePointers, :threePointerAttempts, :twoPointers, :twoPointerAttempts, :time, :totalTime

  def to_s()
    @name.to_s + " " +  @number.to_s + " " + @freeThrows.to_s
  end

  def initialize(number,name)
    @freeThrows, @freeThrowAttempts,@personalFouls,@technicalFoulds,@threePointers,@threePointerAttempts, @twoPointers, @twoPointerAttempts = 0
    @name = name
    @number = number
  end

  #starttime should only be called first, or after endtime. no methods are exposed otherwise, and thus the functioning of the class relies on it
  def startTime()
    if @time != nil
      puts "ERROR: time in " + @number.to_s + " off, not adding"
    else
      @time = Time.now
    end
  end

  def stopTime()
    if @time != nil
      @totalTime += Time.now.to_i - @time.to_i
      @time = nil
    end
  end

  def madeFreeThrow()
    @freeThrowAttempts+=1
    @freeThrows+=1
  end
  
end

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
  end

  end

  def switchPlayer(goingIn, goingOut)
    self.addPlayer(goingIn)
    self.remPlayer(goingOut)
  end

  public
  def addPlayer(goingIn)
    @playersOnCourt.push(goingIn)
    goingIn.startTime()
  end

  def remPlayer(goingOut)
    @playersOnCourt.remove(goingOut)
    goingOut.stoptime()
  end

  public
  def reset(numbers)
    @playersOnCourt.each do |player|
      self.remPlayer(player)
    end
    @playersOnCourt = []
    if numbers.length == 5
      numbers.each do |number|
        self.addPlayer(@players[number])
      end
    else puts "not 5 players, try again"
  end
  
  def to_s()
    out = ""
    @players.each do |player|
      out += player.to_s + ", "
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

class Player
  attr_reader :number,
              :name,
              :personalFouls,
              :technicalFouls,
              :freeThrows,
              :freeThrowAttempts,
              :threePointers,
              :threePointerAttempts,
              :twoPointers,
              :twoPointerAttempts,
              :time,
              :totalTime

  def initialize(number,name)
    @freeThrows, @freeThrowAttempts,@personalFouls,@technicalFouls,@threePointers,@threePointerAttempts, @twoPointers, @twoPointerAttempts, @totalTime = 0,0,0,0,0,0,0,0,0
    @name = name
    @number = number
  end

  def to_s
    "name: " + @name.to_s + " number: " +  @number.to_s
  end

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
    else
      puts "error with players time. player: " + self
  	end
  end

  def shot(undo,type,successful)
    val = 1
    if undo
      val *= -1
    end

    case type
      when 'f'
        @freeThrowAttempts+=val
        @freeThrows+=val if successful
      when '2'
        @twoPointerAttempts+=val
        @twoPointers+=val if successful
      when '3'
        @threePointerAttempts+=val
        @threePointers+=val if successful
    end
  end

  def personalFoul(undo)
    @personalFouls += undo ? -1 : 1
    puts "player " + self + " has 5 personal fouls" if @personalFouls == 5
  end

  def technicalFoul(undo)
    @technicalFouls += undo ? -1 : 1
  end

end



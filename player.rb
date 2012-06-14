class Player
  attr_reader :number, :name, :personalFouls, :technicalFouls, :freeThrows, :freeThrowAttempts, :threePointers, :threePointerAttempts, :twoPointers, :twoPointerAttempts, :time, :totalTime

  def to_s
    "name: " + @name.to_s + "\n number: " +  @number.to_s + "\n time in: " + @totalTime.to_s + "\n free throws: " + @freeThrows.to_s + "\n free throw attemps: " + @freeThrowAttempts.to_s + "\n3 pointers: " + @threePointers.to_s + "\n 3 pointer attemps: " + @threePointerAttempts.to_s
  end

  def initialize(number,name)
    @freeThrows, @freeThrowAttempts,@personalFouls,@technicalFoulds,@threePointers,@threePointerAttempts, @twoPointers, @twoPointerAttempts, @totalTime = 0,0,0,0,0,0,0,0,0
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
    if @totalTime == nil
      puts "well theres your problem"
      @totalTime = 0
    end
    if @time != nil
      @totalTime += Time.now.to_i - @time.to_i
      puts (Time.now.to_i - @time.to_i).to_s
      @time = nil
    end
  end

  def madeFreeThrow(undo)
    if undo != true
      @freeThrowAttempts+=1
      @freeThrows+=1
    else
      @freeThrowAttempts-=1
      @freeThrows-=1
    end
  end

  def shotFreeThrow(undo)
    if undo != true
      @freeThrowAttempts+=1
    else
      @freeThrowAttempts -= 1
    end
  end

    def made3Pointer(undo)
    if undo != true
      @threePointerAttempts+=1
      @threePointers+=1
    else
      @threePointerAttempts-=1
      @threePointers-=1
    end
  end

  def shot3Pointer(undo)
    if undo != true
      @threePointerAttempts+=1
    else
      @threePointerAttempts -= 1
    end
  end


  def made2Pointer(undo)
    if undo != true
      @twoPointerAttempts+=1
      @twoPointers+=1
    else
      @twoPointerAttempts-=1
      @twoPointers-=1
    end
  end

  def shot2Pointer(undo)
    if undo != true
      @twoPointerAttempts+=1
    else
      @twoPointerAttempts -= 1
    end
  end
  
end



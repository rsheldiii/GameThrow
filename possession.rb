class Possession#so right now you can still create multiple instances of possession but it only accesses one object. Maybe I need that anyways
  attr_reader :possession
  @possession = nil

  def to_s()
    @possession
  end

  def switch()
    @possession = :Home if @possession == :Away
    @possession = :Away if @possession == :Home
  end

  def reset(str)
    set(str)
  end

  def set(str)
    if str.lstrip[0].downcase == 'h'
      @possession = :Home
    elsif str.lstrip[0].downcase == 'a'
      @possession = :Away
    else
      puts "possession not understood: " + str 
    end
  end

  def opposite(str)#for undo mostly
    return :Home if str.lstrip[0].downcase == 'a'
    return :Away if str.lstrip[0].downcase == 'h'
  end
end




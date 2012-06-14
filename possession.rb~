class Possession#so right now you can still create multiple instances of possession but it only accesses one object. Maybe I need that anyways
  @@possession = nil
  def Possession.possession
    return @@possession
  end

  def Possession.switch()
    @@possession = 'Home' if @@possession == 'Away'
    @@possession = 'Away' if @@possession == 'Home'
  end

  def Possession.reset(str)
    Possession.set(str)
  end

  def Possession.set(str)
    #supposed to smartly set possession
    if str.lstrip[0].downcase == 'h'
      @@possession = 'Home'
    elsif str.lstrip[0].downcase == 'a'
      @@possession = 'Away'
    else
      return "possession not understood, try again"
    end
  end

  def Possession.opposite(str)#for undo mostly
    return 'Home' if str.lstrip[0].downcase == 'a'
    return 'Away' if str.lstrip[0].downcase == 'h'
  end
end




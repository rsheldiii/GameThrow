
require './player.rb'
require './team.rb'
require './gameclosure.rb'
require './possession.rb'

class Game
  private_class_method :new
  def Game.create()
    puts "creating game"
    @lastLine = "flerp"
    puts @lastLine
    puts "enter the name and numbers of the home team in pairs, ie '33,John Rogers,42,Michael Smith' etc without the quotes"
    hometeam = "1,first entry,2,second entry,3,third entry,4,fourth entry,5,fifth entry"#gets.chomp
    puts "now enter the away team"
    awayteam = "6,sixth entry,7,seventh entry,8,eighth entry,9,ninth entry,10,tenth entry"#gets.chomp
    puts "where is the options file? relative path"
    optfile = "gamefunctions"#gets.chomp

    hteamplayerarr = []
    ateamplayerarr = []
    
    hteamarr = hometeam.scan(/[^,]+/).each_slice(2) {|b| hteamplayerarr.push(b)}
    ateamarr = awayteam.scan(/[^,]+/).each_slice(2) {|a| ateamplayerarr.push(a)} 
    puts hteamplayerarr
    
    hteamplayers = []
    ateamplayers = []

    hteamplayerarr.each {|arr| hteamplayers.push(Player.new(arr[0],arr[1]))}
    ateamplayerarr.each {|arr| ateamplayers.push(Player.new(arr[0],arr[1]))}

    
    parser = Parser.new(optfile)
    hometeam = Team.new(hteamplayers)
    awayteam = Team.new(ateamplayers)
    return new(hometeam,awayteam,parser)
  end
 
  def initialize(hometeam, awayteam, parser)
    @parser = parser
    @teams= {"Home" => hometeam, "Away" => awayteam}
  end

  def to_s
    "Home team: " + @teams["home"].to_s + "\nAway team: " + @teams["away"].to_s
  end

  #precondition: done before the game clock starts
  def startingLineup()
    begin
      puts "enter the starting lineup for the home team"
      temp = ['1','2','3','4','5']#gets.chomp.scan(/[^,]+/)
      bool = @teams["Home"].reset(temp,false)
    end while bool == false
    
    begin
      puts "enter the starting lineup for the away team"
      temp = ['6','7','8','9','10']#gets.chomp.scan(/[^,]+/)	
      bool = @teams["Away"].reset(temp,false)
    end while bool == false
  end

  def stopClock(gameclosure)
    puts "stopping clock"
    @teams.each do |name,obj| obj.stopClock end
  end

  def startClock(gameclosure)
    @teams.each do |name,obj| obj.startClock end
  end

  def findPlayer(number,possession = nil)
    return @teams[Possession.possession].findPlayer(number) if possession != nil
    @teams.each do |name,team|
      return team.findPlayer(number) if team.findPlayer(number) != nil
    end
    return nil
  end


  def shotAndMadeFreeThrow(gameclosure)
    number = gameclosure.regexp["number"]#it's not going to be regexp[1] every time. in fact, sometimes, it's going to be two different functions. If it was, I would standardize this using a block, having the block yield the action to take while the function using the yield would be calling player.send
    player = findPlayer(number,Possession.possession)
    if player != nil
      player.madeFreeThrow(gameclosure.undo) 
    else puts "player not found, try again"
    end
    return true
  end

  def shotFreeThrow(gameclosure)
    number = gameclosure.regexp["number"]
    player = findPlayer(number,Possession.possession)
    player.shotFreeThrow(gameclosure.undo) if player != nil
    return true
  end

  def shotAndMade3Pointer(gameclosure)
    number = gameclosure.regexp["number"]
    player = findPlayer(number, Possession.possession)
    if player != nil
      player.made3Pointer(gameclosure.undo) 
    else puts "player not found, try again"
    end
    return true
  end

  def shot3Pointer(gameclosure)
    number = gameclosure.regexp["number"]#it's not going to be regexp[1] every time. in fact, sometimes, it's going to be two different functions. If it was, I would standardize this using a block, having the block yield the action to take while the function using the yield would be calling player.send
    player = findPlayer(number,Possession.possession)
    if player != nil
      player.shot3Pointer(gameclosure.undo) 
    else puts "player not found, try again"
    end
    return true
  end

  def printPlayer(gameclosure)
    number = gameclosure.regexp["number"]
    player = findPlayer(number)
    puts player.to_s if player != nil
  end

  def resetPossession(gameclosure)
    possession = gameclosure.regexp[1]
    puts possession
    if gameclosure.undo != true
      puts Possession.set(possession)
    else
      possession = Possession.opposite(possession)
      puts Possession.set(possession)
    end
    return true
  end 




  def start()
    while Possession.possession != "Home" and Possession.possession != "Away"
      puts Possession.possession
      puts "possession: home or away? clock starts after entry"
      Possession.set(gets[0,4])
    end
    startClock(nil)
    puts "clock started, game commence"
  #start the game
    while line = gets
      callParse(line)
    end
  end

  def undo(gameclosure)

    @lastLine = @lastLine.gsub(/^u*/,'')#if we already negated this string, kill the u so we can add it again naively
    @lastLine = 'u'+@lastLine.lstrip
    callParse(@lastLine) if @lastLine.chomp != "u"
  end

  def callParse(line)
    matchdata = @parser.parse(line)#prepend u after all whitespace is removed just in case
    if matchdata == nil
      puts "no match found, try again" 
      
    else  
      if matchdata["regexp"].names.include?("undo") == true
        undo = matchdata["regexp"]["undo"] == 'u'? true:false
      end
       undoable =  send(matchdata["function"],Gameclosure.new(Possession.possession, matchdata["regexp"], undo))
    end
    @lastLine = line if undoable == true
  end

end
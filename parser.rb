class Parser
	attr_reader :keywordMap
  def initialize()
    @keywordMap = {}
    #actions like shooting that pertain to a single player

      @keywordMap["shot"] = Regexp.new('\b(?<undo>u)?(?<command>p)(?<number>[0-9]{2})(?<type>.)(?<sunk>s)?\b')
      #Shot encompasses all possibilities of a shot:
      #allows for any number of types of shots. will support free throw, penalty shot (for technicals), layup, 2 pointer, 3 pointer currently
      #command ends with confirmation of shot; all other parts of the command can be typed while waiting for the shot to go in
      #undo possible
      @keywordMap["foul"] = Regexp.new('\b(?<possession>[ah])(?<first>[0-9]{2})(?<command>f)(?<second>[0-9]{2})\b')
      #actual foul shots are done through the Shot directive


    #actions that affect the game as a whole
      # "stopClock"
        @keywordMap["stopClock"] = Regexp.new('\b(?<command>sc)\b')
      # "startClock"
        @keywordMap["startClock"] = Regexp.new('\bec\b')


    #debug actions
      # "printPlayer"
        @keywordMap["printPlayer"] = Regexp.new('\b(?<command>p)(?<number>[0-9]{2})\b')

    #actions that allow you to modify game state outside of the game, aka "oh sh*t" actions
      # "resetPossession"
        @keywordMap["resetPossession"] = Regexp.new('\b(?<undo>u)?ps(?<possession>[ah])\b')
      # "undo"
        @keywordMap["undo"] = Regexp.new('\bu\b')
        @keywordMap["help"] = Regexp.new('\bh\b')
  end

  def parse(line)
    @keywordMap.each { |function,regexp|
      if line =~ regexp
        return {"function" => function,"regexp" =>regexp.match(line)}
      end
      }
    return nil
  end
  
end

require './command.rb'

class Parser
	attr_reader :keywordMap
  def initialize()
    @keywordMap = []#TODO: load from ini. this is fine for now
    #actions like shooting that pertain to a single player

      @keywordMap << Command.new("shot",
                                 Regexp.new('\b(?<undo>u)?(?<command>p)(?<number>[0-9]{2})(?<type>.)(?<sunk>s)?\b'),
                                 "shot command. controls all point scoring to the board",
                                 "[undo?]p[number][type f,2,3][successful s]")
      
      @keywordMap << Command.new("foul",
                                  Regexp.new('\b(?<undo>u)?(?<possession>[ah])(?<first>[0-9]{2})(?<command>f)(?<second>[0-9]{2})\b'),
                                  "foul command. allows one player to foul another. does not count technicals. points during foul shot should be added via shot command",
                                  "[undo?][possession a,h][fouler]f[foulee]")
      #actual foul shots are done through the Shot directive


    #actions that affect the game as a whole
      # "stopClock"
        @keywordMap << Command.new("stopClock",
                                  Regexp.new('\b(?<command>sc)\b'),
                                  "end clock command. stops game clock and timing clock for all players on court",
                                  "ec")
      # "startClock"
        @keywordMap << Command.new("startClock",
                                    Regexp.new('\bec\b'),
                                    "Start clock command. starts game clock and timing clock for all players on court",
                                    "sc")


    #debug actions
      # "printPlayer"
        @keywordMap << Command.new("printPlayer",
                                    Regexp.new('\b(?<command>p)(?<number>[0-9]{2})\b'),
                                    "prints player's object. currently name number # points #fouls",
                                    "p[number]")


    #actions that allow you to modify game state outside of the game, aka "oh sh*t" actions
      # "resetPossession"
        @keywordMap << Command.new("resetPossession",
                                  Regexp.new('\b(?<undo>u)?ps(?<possession>[ah])\b'),
                                  "resets possession to either team",
                                  "[undo?]ps[possession h,a]")
      # "undo"
        @keywordMap << Command.new("undo",
                                  Regexp.new('\bu\b'),
                                  "undo command. undos the last command, if possible. if not will probably alert you idk yet",
                                  "u")
        @keywordMap << Command.new("Help",
                                    Regexp.new('\bh\b'),
                                    "Help command. displays this help dialogue",
                                    "h")
  end

  def parse(line)
    @keywordMap.each { |command|
      if line =~ command.regex
        return command
      end
      }
    return nil
  end
  
end

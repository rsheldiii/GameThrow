require './gameParser.rb'
require './game.rb'


derp = Regexp.new(/(?<derp>.*).*?/)
puts "fleleeelelel"
matchdata = derp.match("blah")
print matchdata["derp"]
game = Game.create()
game.startingLineup


puts game

game.start


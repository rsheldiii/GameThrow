require './gameParser.rb'
require './game.rb'


derp = Regexp.new(/(?<word>.*).*?/)
puts "line 6"
matchdata = derp.match("test")
print matchdata["word"]
game = Game.create()
game.startingLineup


puts game

game.start


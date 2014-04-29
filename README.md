#GameThrow
=========

a flexible,customizable basketball statistics application written entirely in Ruby.

currently in Alpha, undergoing a major rewrite for simplicity, efficiency, and readability.






#CURRENT STRUCTURE:
currently the application is structured as such (classmap):

- game
    - parser
    - court
        - home team
            - [players]
        - away team
            - [players]


game includes all game-related, top-level functions, like the command stack, command functions, and functions like start() which sets the field for a new game to start.

parser is currently an interim object that may be absorbed into game later. It contains regex commands to parse text input from the controller.
court is a court object, with two teams, a possession, a game clock, and similar.
teams are collections of players, with a list of 5 currently on the field, that controls how the players interact with each other. Example functions are stopTime which stops all players times in the case of a foul, OB, timeout, etc.
players are self-explanatory, and contain all statistics on a given player



#TODO:

- need to define an interface to the Game function that trickles down throughout the class map
- cmdStack needs to be fixed
- function for fouls
- needs to like run and stuff
require 'gosu'
require_relative "gameWindow"

class Game 
    def initialize
        @mainWindow = GameWindow.new 800, 600, false
    end

    def start
        @mainWindow.show
    end
end

game = Game.new
game.start



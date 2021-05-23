require 'gosu'
require 'json'
require_relative "gameWindow"

class Game 
    def initialize(width=800, 
                   height=600, 
                   fullScreen=false, 
                   updateInterval=17,
                   caption="strategicRuby")
        @mainWindow = GameWindow.new(width, 
                                     height, 
                                     fullScreen,
                                     updateInterval,
                                     caption)
    end

    def start
        @mainWindow.show
    end
end

mainConfigFile = File.read('jsonConfig/main.json')
mainConfig = JSON.parse(mainConfigFile)

game = Game.new(mainConfig["windowWidth"], 
                mainConfig["windowHeight"], 
                mainConfig["fullScreen"], 
                mainConfig["updateInterval"], 
                mainConfig["windowCaption"])

game.start



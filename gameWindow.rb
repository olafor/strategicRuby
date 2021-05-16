require 'gosu'
require_relative 'dispatcher'
require_relative 'hashConfig/controlHashes'

class GameWindow < Gosu::Window
    def initialize(width=800, height=600, fullscreen=false, update_interval=80.0)
        super
        self.caption = 'strategicRuby'
        @isOngoing = true
        @dispatcher = Dispatcher.new
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end

    def needs_redraw?
      @isOngoing
    end

    def update
      @dispatcher.updateMousePos(mouse_x, mouse_y)
      if button_down?(Gosu::MsLeft)
        @dispatcher.handleInput(INPUT[:MOUSE_LEFT])
      end

      if button_down?(Gosu::MsRight)
        @dispatcher.handleInput(INPUT[:MOUSE_RIGHT])
      end
      @dispatcher.updateAnimation
    end

    def draw
      @dispatcher.draw
    end
end


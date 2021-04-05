require 'gosu'

class GameWindow < Gosu::Window
    def initialize(width= 800, height=600, fullscreen=false)
        super
        self.caption = 'Hej världen!'
        @message = Gosu::Image.from_text(self, 'Hello World!',  Gosu.default_font_name, 30)
    end

    def draw
        @message.draw(10,10,10)
    end
end

window = GameWindow.new
window.show 

require 'gosu'

def getDiff(a, b)
    if a > b
        return a - b
    else
        return b - a
    end
end

class GameWindow < Gosu::Window
    def initialize(width=800, heigth=600, fullscreen=false)
        super
        self.caption = 'iterationEtt'
        @x = width/2
        @y = heigth/2
        @targetX = 0
        @targetY = 0
        @unitSpeed = 2
        @count = 0
        @isMoving = false
    end

    def update
        if button_down?(Gosu::MsRight)
            @targetX = mouse_x
            @targetY = mouse_y
            @isMoving = true
            @count += 1
        end
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end

    def needs_redraw?
        @count == 0 || @isMoving == true
    end
    
    def draw
        @counter = Gosu::Image.from_text(
            self, "#{@count}", Gosu.default_font_name, 30)
        @counter.draw(10, 10, 0)

        if @isMoving
            STDOUT.puts("x: #{@x}, y: #{@y}")
            @target = Gosu::Image.from_text(
                self, "X", Gosu.default_font_name, 30)
            @target.draw(@targetX, @targetY, 0)

            @deltaX = getDiff(@x, @targetX)
            @deltaY = getDiff(@y, @targetY)
            @hypothenuse = Math.hypot(@deltaX, @deltaY)

            if @x < @targetX
                @x += @deltaX/@hypothenuse * @unitSpeed
            elsif @x > @targetX
                @x -= @deltaX/@hypothenuse * @unitSpeed
            end

            if @y < @targetY
                @y += @deltaY/@hypothenuse * @unitSpeed
            elsif @y > @targetY
                @y -= @deltaY/@hypothenuse * @unitSpeed
            end

            if @x > @targetX - 30 && @x < @targetX + 30 && @y > @targetY - 30 && @y < @deltaY + 30
                @isMoving = false 
            end
        end

        @message = Gosu::Image.from_text(
            self, 'O', Gosu::default_font_name, 30)
        @message.draw(@x, @y, 0)
    end
end

window = GameWindow.new
window.show
        
        

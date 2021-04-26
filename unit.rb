require 'gosu'

class AnimatedUnit
  attr_accessor :currentX, :currentY, :targetX, :targetY, :isMoving, :isSelected
  attr_accessor :spriteSheet, :displayedImage, :sheetPosition, :sheetPosMax
  attr_accessor :width, :height 

  def initialize(sourceFile, numberOfFrames, timeInSeconds, cX, cY, speed)
    @name = sourceFile
    @spriteSheet = Gosu::Image.new(sourceFile)
    @numberOfFrames = numberOfFrames
    @width = @spriteSheet.width / @numberOfFrames
    @height = @spriteSheet.height
    @currentX = cX
    @targetX = @currentX
    @currentY = cY
    @targetY = @currentY
    @sheetPosition = 0
    @displayedImage = @spriteSheet.subimage(0, 0, @width, @height)
    @unitSpeed = speed
    @isMoving = false
    @isSelected = false
    @margin = 1.0
  end

  def updateAnimation
    @sheetPosition += @width
    @sheetPosition = 0 if @sheetPosition >= @spriteSheet.width - @width
    @displayedImage = @spriteSheet.subimage(@sheetPosition, 0, @width, @height)
  end

  def stopMovementIfAtTarget
    if @currentX < @targetX + @margin &&
       @currentX > @targetX + @margin &&
       @currentY < @targetY + @margin &&
       @currentY > @targetY + @margin
      @isMoving = false
    end
  end

  def updatePosition(deltaX, deltaY, hypothenuse)
    if @currentX < @targetX
        @currentX += deltaX/hypothenuse * @unitSpeed
    else
        @currentX -= deltaX/hypothenuse * @unitSpeed
    end

    if @currentY < @targetY
        @currentY += deltaY/hypothenuse * @unitSpeed
    else
        @currentY -= deltaY/hypothenuse * @unitSpeed
    end
    stopMovementIfAtTarget
  end

  def calculateMovementAndUpdate
    deltaX = @targetX >= @currentX ? @targetX - @currentX : @currentX - @targetX
    deltaY = @targetY >= @currentY ? @targetY - @currentY : @currentY - @targetY
    hypothenuse = Math.hypot(deltaX, deltaY)
    updatePosition(deltaX, deltaY, hypothenuse)
  end

  def drawImage
    calculateMovementAndUpdate if isMoving
    @displayedImage.draw(@currentX - @width/2, @currentY - @height/2)
  end

  def selectIfInRange(mouseX, mouseY)
      if mouseX >= @currentX - @width/2 && mouseX <= @currentX + @width/2 && 
         mouseY >= @currentY - @height/2 && mouseY <= @currentY + @height/2
        @isSelected = true
      else
        @isSelected = false
      end
  end
  
  def setTargetIfSelected(mouseX, mouseY)
    if @isSelected
      @targetX = mouseX
      @targetY = mouseY
      @isMoving = true
    end
  end
end

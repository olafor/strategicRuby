require 'gosu'

class ProtoUnit
  attr_accessor :currentX, :currentY, :targetX, :targetY, :isMoving, :isSelected
  attr_accessor :displayedImage
  attr_accessor :width, :height 

  def initialize(sourceFile, timeInSeconds, cX, cY, speed)
    @name = sourceFile
    @displayedImage = Gosu::Image.new(sourceFile)
    @width = @displayedImage.width
    @height = @displayedImage.height
    @currentX = cX
    @targetX = @currentX
    @currentY = cY
    @targetY = @currentY
    @unitSpeed = speed
    @isMoving = false
    @isSelected = false
  end

  def updateAnimation
    return false
  end

  def stopMovementIfAtTarget
    if @currentX < @targetX + @width / 2 &&
       @currentX > @targetX - @width / 2 &&
       @currentY < @targetY + @height / 2 &&
       @currentY > @targetY - @height / 2
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

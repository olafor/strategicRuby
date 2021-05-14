require 'gosu'

class ProtoUnit
  attr_accessor :currentX, :currentY, :targetX, :targetY, :isMoving, :isSelected
  attr_accessor :displayedImage
  attr_accessor :width, :height 

  def initialize(unitData)
    @type = unitData["type"]
    @displayedImage = Gosu::Image.new(unitData["source"])
    @width = @displayedImage.width
    @height = @displayedImage.height
    @currentX = unitData["currentX"]
    @targetX = @currentX
    @currentY = unitData["currentY"]
    @targetY = @currentY
    @unitSpeed = unitData["speed"]
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

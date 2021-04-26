require 'gosu'
require 'json'
require_relative 'unitHandler'
require_relative '.baseline/unitConstants'

class Dispatcher
  def initialize()
    file = File.read('./jsonConfig/unitData.json')
    @unitData = JSON.parse(file)
    @movingCoin = AnimatedUnit.new(
      @unitData['coin']["source"],
      @unitData['coin']["numberOfFrames"],
      @unitData['coin']["timeInSeconds"],
      @unitData['coin']["currentX"],
      @unitData['coin']["currentY"],
      @unitData['coin']["speed"])
    @movingStickFigure = AnimatedUnit.new(
      @unitData['sample']["source"],
      @unitData['sample']["numberOfFrames"],
      @unitData['sample']["timeInSeconds"],
      @unitData['sample']["currentX"],
      @unitData['sample']["currentY"],
      @unitData['coin']["speed"])
  end

  def updateMousePos(mouseX, mouseY)
    @mouseX = mouseX
    @mouseY = mouseY
  end

  def handleInput(input)
    case input
    when INPUT[:MOUSE_LEFT]
      @movingStickFigure.selectIfInRange(@mouseX, @mouseY)
      @movingCoin.selectIfInRange(@mouseX, @mouseY)
    when INPUT[:MOUSE_RIGHT] 
      @movingCoin.setTargetIfSelected(@mouseX, @mouseY)
      @movingStickFigure.setTargetIfSelected(@mouseX, @mouseY)
    end

  end
  
  def updateAnimation
    @movingCoin.updateAnimation
    @movingStickFigure.updateAnimation
  end

  def draw
    @movingCoin.drawImage
    @movingStickFigure.drawImage
  end

end

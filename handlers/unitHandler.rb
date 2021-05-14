require 'gosu'
require 'json'
require_relative '../unit/animatedUnit'
require_relative '../hashConfig/assetHashes.rb'
require_relative '..hashConfig/unitHashes.rb'

class UnitHandler
  def initialize()
    @assets = UNIT_ASSETS
    @units = UNIT

    unitData = JSON.parse(file)
    unitData.each do |key, data|
      @units.append(ProtoUnit.new(
        unitsData[key]))
    end
  end

  def updateMousePos(mouseX, mouseY)
    @mouseX = mouseX
    @mouseY = mouseY
  end

  def handleInput(input)
    case input
    when INPUT[:MOUSE_LEFT]
      @units.each do |unit|
        unit.selectIfInRange(@mouseX, @mouseY)
      end
    when INPUT[:MOUSE_RIGHT] 
      @units.each do |unit|
        unit.setTargetIfSelected(@mouseX, @mouseY)
      end
    end

  end
  
  def updateAnimation
    @units.each do |unit|
      unit.updateAnimation
    end
  end

  def draw
    @units.each do |unit|
      unit.drawImage
    end
  end

end

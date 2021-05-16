require 'gosu'
#require 'json'
require_relative '../unit/animatedUnit'
require_relative '../hashConfig/assetHashes.rb'
require_relative '../hashConfig/unitHashes.rb'
require_relative '../hashConfig/controlHashes.rb'

class UnitHandler
  def initialize()
    @assets = Hash.new
    UNIT_ASSETS.each do |key, data|
      gosuImage = Gosu::Image.new(UNIT_ASSETS[key])
      @assets[UNIT_ASSETS[key]] = gosuImage
    end

    @units = []
    BASIC_UNIT.each do |key, data|
      image = @assets[data[:asset]]
      unitData = data.clone
      unitData[:asset] = image
      @units.append(ProtoUnit.new(unitData))
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

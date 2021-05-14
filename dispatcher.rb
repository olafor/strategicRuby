require 'gosu'
require_relative './handlers/unitHandler'
require_relative './handlers/aiHandler'
require_relative './handlers/menuHandler'
require_relative './handlers/envHandler'
require_relative '.baseline/unitHashes'

class Dispatcher
  def initialize()
    @unitHandler = UnitHandler.new
  end

  def updateMousePos(mouseX, mouseY)
    @unitHandler.updateMousePos(mouseX, mouseY)
  end
  
  def handleInput(input)
    @unitHandler.handleInput(input)
  end

  def updateAnimation
    @unitHandler.updateAnimation
  end

  def draw
    @unitHandler.draw
  end

end

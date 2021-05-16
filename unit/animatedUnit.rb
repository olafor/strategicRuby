require 'gosu'
require_relative 'protoUnit'

class AnimatedUnit < ProtoUnit
  attr_accessor :spriteSheet, :sheetPosition, :sheetPosMax

  def initialize(unitData)
    super(unitData)
    @numberOfFrames = unitData[:numberOfFrames]
    @spriteSheet = @displayedImage
    @width = @spriteSheet.width / @numberOfFrames
    @height = @spriteSheet.height
    @displayedImage = @spriteSheet.subimage(0, 0, @width, @height)
    @sheetPosition = 0
  end

  def updateAnimation
    @sheetPosition += @width
    @sheetPosition = 0 if @sheetPosition >= @spriteSheet.width - @width
    @displayedImage = @spriteSheet.subimage(@sheetPosition, 0, @width, @height)
    return true
  end
end

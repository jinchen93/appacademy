require 'singleton'

class Piece
  attr_reader :color, :position

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def symbol
    "P"
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
    @color = :blue
  end

  def moves
    []
  end

  def symbol
    "_"
  end
end

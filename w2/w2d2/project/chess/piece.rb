require 'singleton'

class Piece
  attr_accessor :position
  attr_reader :color, :board

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def valid_moves
    moves.reject do |move|
      move_into_check?(move)
    end
  end

  def symbol
    "P"
  end

  # def inspect
  #   "#{self.class} - #{position} - #{color}"
  # end

  private

  def move_into_check?(end_pos)
    board_clone = @board.dup
    board_clone.move_piece!(@position, end_pos)
    board_clone.in_check?(@color)
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
    @color = :black
  end

  def moves
    []
  end

  def symbol
    "▢"
  end
end

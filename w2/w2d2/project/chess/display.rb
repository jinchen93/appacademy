require 'pry'
require 'byebug'

require "colorize"
require_relative "board"
require_relative "cursor"
require_relative "all_pieces"

class Display
  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    system('clear')
    print "  "
    8.times { |i| print "#{i} " }
    puts ''

    @board.grid.each_with_index do |row, row_idx|
      print "#{row_idx} "
      row.each_with_index do |piece, col_idx|
        current_pos = [row_idx, col_idx]

        if current_pos == @cursor.cursor_pos
          print piece.symbol.on_white.blink
        else
          print piece.symbol.colorize(piece.color)
        end

        print ' '
      end

      puts ''
    end

    nil

  end
end

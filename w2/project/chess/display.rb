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
          print piece.to_s.blue.on_white.blink
        else
          print piece.to_s
        end

        print ' '
      end

      puts ''
    end

    nil

  end
end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  # loop do
    display.render
  #   display.cursor.get_input
  # end
  # queen = Queen.new(board, [2,0])
  # p queen.moves
  king = King.new(board, [3,3])
  p king.moves
end

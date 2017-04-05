require_relative 'piece'

class Board
  attr_accessor :grid

  def initialize(grid = [])
    @grid = grid
    setup_grid if @grid.empty?
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]

    unless piece.valid_moves.include?(end_pos)
      raise('Piece can not move to the end position!')
    end

    if piece.is_a?(NullPiece)
      raise("Wrong start position, no piece at this position.")
    elsif is_piece?(end_pos) && !is_opponent_piece?(start_pos, end_pos)
      raise("Wrong end position, there is a piece at this position")
    end

    self[end_pos] = piece
    self[end_pos].position = end_pos
    self[start_pos] = NullPiece.instance
  end

  def move_piece!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].position = end_pos
    self[start_pos] = NullPiece.instance
  end


  def in_bounds?(pos)
    pos.all? { |ele| ele.between?(0, 7) }
  end

  def is_piece?(pos)
    !self[pos].is_a?(NullPiece)
  end

  def is_opponent_piece?(start_pos, end_pos)
    self[start_pos].color != self[end_pos].color
  end

  def in_check?(color)
    king_pos = find_king(color)
    opponent_color = other_color(color)

    opponent_pieces = pieces_of_color(opponent_color)
    opponent_moves = moves_of_pieces(opponent_pieces)

    opponent_moves.include?(king_pos)
  end

  def checkmate?(color)
    pieces = pieces_of_color(color)
    valid_moves = valid_moves_of_pieces(pieces)

    in_check?(color) && valid_moves.empty?
  end

  def dup
    new_grid = []
    new_board = Board.new()

    @grid.each_with_index do |row, row_idx|
      temp_row = []
      row.each_with_index do |piece, col_idx|
        if piece.position.nil?
          temp_row << NullPiece.instance
        else
          temp_row << piece.class.new(new_board, piece.position.dup, piece.color)
        end
      end
      new_grid << temp_row
    end

    new_board.grid = new_grid
    new_board
  end

  private

  def find_king(color)
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        if piece.is_a?(King) && piece.color == color
          return [row_idx, col_idx]
        end
      end
    end
  end

  def pieces_of_color(color)
    pieces = []

    @grid.each do |row|
      pieces.concat(row.select { |piece| piece.color == color })
    end

    pieces
  end

  def moves_of_pieces(pieces)
    moves = []

    pieces.each do |piece|
      moves.concat(piece.moves)
    end

    moves.uniq
  end

  def valid_moves_of_pieces(pieces)
    moves = []

    pieces.each do |piece|
      moves.concat(piece.valid_moves)
    end

    moves.uniq
  end

  def other_color(color)
    color == :red ? :blue : :red
  end

  def setup_grid
    @grid << [
      Rook.new(self, [0,0], :blue),
      Knight.new(self, [0,1], :blue),
      Bishop.new(self, [0,2], :blue),
      Queen.new(self, [0,3], :blue),
      King.new(self, [0,4], :blue),
      Bishop.new(self, [0,5], :blue),
      Knight.new(self, [0,6], :blue),
      Rook.new(self, [0,7], :blue)
    ]

    @grid << [
      Pawn.new(self, [1,0], :blue),
      Pawn.new(self, [1,1], :blue),
      Pawn.new(self, [1,2], :blue),
      Pawn.new(self, [1,3], :blue),
      Pawn.new(self, [1,4], :blue),
      Pawn.new(self, [1,5], :blue),
      Pawn.new(self, [1,6], :blue),
      Pawn.new(self, [1,7], :blue)
    ]

    4.times { @grid << Array.new(8) { NullPiece.instance } }

    @grid << [
      Pawn.new(self, [6,0], :red),
      Pawn.new(self, [6,1], :red),
      Pawn.new(self, [6,2], :red),
      Pawn.new(self, [6,3], :red),
      Pawn.new(self, [6,4], :red),
      Pawn.new(self, [6,5], :red),
      Pawn.new(self, [6,6], :red),
      Pawn.new(self, [6,7], :red)
    ]

    @grid << [
      Rook.new(self, [7,0], :red),
      Knight.new(self, [7,1], :red),
      Bishop.new(self, [7,2], :red),
      Queen.new(self, [7,3], :red),
      King.new(self, [7,4], :red),
      Bishop.new(self, [7,5], :red),
      Knight.new(self, [7,6], :red),
      Rook.new(self, [7,7], :red)
    ]
  end

end

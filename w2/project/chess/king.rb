class King < Piece
  include SteppingPiece

  def move_diffs
    [
      [-1, 0],
      [-1, 1],
      [-1, -1],
      [0, 1],
      [0, -1],
      [1, 0],
      [1, 1],
      [1, -1]
    ]
  end

  def symbol
    "K"
  end
end

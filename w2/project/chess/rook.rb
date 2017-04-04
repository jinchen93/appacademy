class Rook < Piece
  include SlidingPiece

  def move_dirs
    [:horizontal, :vertical]
  end

  def symbol
    "R"
  end
end

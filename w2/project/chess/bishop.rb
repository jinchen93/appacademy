class Bishop < Piece
  include SlidingPiece

  def move_dirs
    [:diagonal]
  end

  def symbol
    "B"
  end
end

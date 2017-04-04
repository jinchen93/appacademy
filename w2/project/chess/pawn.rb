class Pawn < Piece
  def moves
    valid_moves = []

    if at_start_row?
      valid_moves.concat(forward_steps)
    else
      valid_moves.concat(forward_dir)
    end

    valid_moves.select do |pos|
      !@board.is_piece?(pos) && @board.in_bounds?(pos)
    end
  end

  def at_start_row?
    [1, 6].include?(@position[0])
  end

  def forward_dir
    if @color == :red
      [[-1, 0]]
    else
      [[1, 0]]
    end
  end

  def forward_steps
    if @color == :red
      [[-1, 0], [-2, 0]]
    else
      [[1, 0], [2, 0]]
    end
  end

  def side_attacks
    if @color == red
      [[-1, -1], [-1, 1]]
    else
      [[1, -1], [1, 1]]
    end
  end


  def symbol
    "P"
  end
end

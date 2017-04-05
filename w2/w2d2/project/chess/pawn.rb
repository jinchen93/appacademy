class Pawn < Piece
  def moves
    valid_moves = []

    if at_start_row?
      valid_moves.concat(forward_steps)
    else
      valid_moves.concat(forward_dir)
    end


    valid_moves.select! do |pos|
      @board.in_bounds?(pos) && !@board.is_piece?(pos)
    end

    attack_moves = side_attacks
    attack_moves.each do |pos|
      if @board.in_bounds?(pos) &&
        @board.is_piece?(pos) &&
        @board[pos].color != @color
        valid_moves << pos
      end
    end

    valid_moves
  end

  def at_start_row?
    [1, 6].include?(@position[0])
  end

  def forward_dir
    if @color == :red
      [[@position[0] - 1, @position[1]]]
    else
      [[@position[0] + 1, @position[1]]]
    end
  end

  def forward_steps
    if @color == :red
      [[@position[0] - 1, @position[1]], [@position[0] - 2, @position[1]]]
    else
      [[@position[0] + 1, @position[1]], [@position[0] + 2, @position[1]]]
    end
  end

  def side_attacks
    if @color == :red
      [[@position[0] - 1, @position[1] - 1], [@position[0] - 1, @position[1] + 1]]
    else
      [[@position[0] + 1, @position[1] - 1], [@position[0] + 1, @position[1] + 1]]
    end
  end


  def symbol
    "♙"
  end
end

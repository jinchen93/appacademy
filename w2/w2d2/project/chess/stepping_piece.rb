module SteppingPiece

  def moves
    potential_pos = move_diffs.map do |diff_pos|
      [diff_pos[0] + @position[0], diff_pos[1] + @position[1]]
    end

    potential_pos.select do |pos|
      @board.in_bounds?(pos) &&
        ( @board.is_opponent_piece?(@position, pos) ||
        !@board.is_piece?(pos) )
    end

  end

  def move_diffs

  end
end

module SlidingPiece

  def moves
    valid_moves = []

    move_dirs.each do |dir|
      directions = []
      case dir
      when :diagonal
        directions = diagonal_dirs
      when :horizontal
        directions = horizontal_dirs
      when :vertical
        directions = vertical_dirs
      end
      valid_moves.concat(directions)
    end

    valid_moves
  end

  private
  def move_dirs
  end

  def horizontal_dirs
    grow_unblocked_moves_in_dir(1, 0) +
    grow_unblocked_moves_in_dir(-1, 0)
  end

  def diagonal_dirs
    grow_unblocked_moves_in_dir(-1, -1) +
    grow_unblocked_moves_in_dir(-1, 1) +
    grow_unblocked_moves_in_dir(1, -1) +
    grow_unblocked_moves_in_dir(1, 1)
  end

  def vertical_dirs
    grow_unblocked_moves_in_dir(0, -1) +
    grow_unblocked_moves_in_dir(0, 1)
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    current_x = @position[0] + dx
    current_y = @position[1] + dy

    valid_pos = []

    until @board.is_piece?([current_x, current_y]) ||
          !@board.in_bounds?([current_x, current_y])
      valid_pos << [current_x, current_y]

      current_x += dx
      current_y += dy
    end

    valid_pos
  end
end

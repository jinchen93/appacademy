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

  # private
  def move_dirs
  end

  def horizontal_dirs
    grow_unblocked_moves_in_dir(0, -1) +
    grow_unblocked_moves_in_dir(0, 1)
  end

  def diagonal_dirs
    grow_unblocked_moves_in_dir(-1, -1) +
    grow_unblocked_moves_in_dir(-1, 1) +
    grow_unblocked_moves_in_dir(1, -1) +
    grow_unblocked_moves_in_dir(1, 1)
  end

  def vertical_dirs
    grow_unblocked_moves_in_dir(1, 0) +
    grow_unblocked_moves_in_dir(-1, 0)
  end

  def grow_unblocked_moves_in_dir(d_row, d_col)
    current_col = @position[1] + d_col
    current_row = @position[0] + d_row
    valid_pos = []

    until !@board.in_bounds?([current_row, current_col]) ||
        @board.is_piece?([current_row, current_col])
      valid_pos << [current_row, current_col]

      current_col += d_col
      current_row += d_row
    end

    if @board.in_bounds?([current_row, current_col]) &&
       @board[[current_row, current_col]].color != @color
      valid_pos << [current_row, current_col]
    end

    valid_pos
  end
end

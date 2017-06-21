class DynamicProgramming
  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    count = 1
    num = 1
    until count == n
      num += 2
      count += 1
    end
    this_blair_num = blair_nums(n - 1) + blair_nums(n - 2) + num
    @blair_cache[n] = this_blair_num
    this_blair_num
  end

  def frog_hops(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }
    return cache if n < 4

    (4..n).each do |i|
      count = i - 1
      steps = []
      until count <= 0
        cache[count].each do |combo|
          sum = combo.inject(:+)
          missing_step = i - sum
          new_combo = combo.dup << missing_step
          steps << new_combo
        end
        count -= 1
      end
      cache[i] = steps
    end

    cache
  end

  def frog_hops_top_down(n)
  end

  def super_frog_hops(n, k)
  end

  def make_change(amt, coins)
  end

  def maze_solver(maze, start_pos, end_pos = nil)
    start_row = start_pos[0]
    start_col = start_pos[1]
    mazes = []
    return mazes if start_row >= maze.length
    return mazes if start_col >= maze[0].length

    return start_pos if maze[start_row][start_col] == 'F'

    # Check top
    mazes << maze_solver(maze, [start_row - 1, start_col])
    # Check bottom
    mazes << maze_solver(maze, [start_row + 1, start_col])
    # Check right
    mazes << maze_solver(maze, [start_row, start_col + 1])
    # Check left
    mazes << maze_solver(maze, [start_row, start_col - 1])

    return mazes.min_by { |maze| maze.length }
  end
end
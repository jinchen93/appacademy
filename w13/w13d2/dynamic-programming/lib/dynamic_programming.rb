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

  end

  def frog_cache_builder(n)
    cache = {
      1 => [[1]],
      2 => [[1, 1], [2]],
      3 => [[1, 1, 1], [1, 2], [3]]
    }

  end

  def frog_hops_top_down(n)
  end

  def super_frog_hops(n, k)
  end

  def make_change(amt, coins)
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

x = DynamicProgramming.new
p x.blair_nums(6)
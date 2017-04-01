require_relative "00_tree_node"

class KnightPathFinder

  DELTAS = [
    [-2, 1],
    [-1, 2],
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [-2, -1]
  ].freeze

  def self.in_bounds?(pos)
    valid_positions = []

    8.times do |row|
      8.times { |col| valid_positions << [row, col] }
    end

    valid_positions.include?(pos)
  end

  def self.valid_moves(pos)
    moves = []
    DELTAS.each do |r, c|
      row, col = pos
      moves << [row + r, col + c]
    end
    moves.select { |move| KnightPathFinder.in_bounds?(move) }
  end

  attr_reader :root

  def initialize(pos)
    @root = PolyTreeNode.new(pos)
    @visited_positions = [pos]
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    valid_moves.reject! { |move| @visited_positions.include?(move) }
    @visited_positions += valid_moves
    valid_moves
  end

  def build_move_tree
    queue = [@root]

    until queue.empty?
      next_node = queue.shift
      new_moves = new_move_positions(next_node.value)

      new_moves.each do |move|
        child_node = PolyTreeNode.new(move)
        next_node.add_child(child_node)
        queue << child_node
      end
    end
  end

  def render
    render_helper(@root, 0)
  end

  def find_path(end_pos)
    end_node = @root.dfs(end_pos)
    trace_path_back(end_node)
  end

  private

  def render_helper(node, depth)
    puts "#{'  ' * depth} #{node.value}"
    node.children.each do |child|
      render_helper(child, depth + 1)
    end
  end

  def trace_path_back(end_node)
    path = []
    current_node = end_node

    until current_node.parent.nil?
      path << current_node.value
      current_node = current_node.parent
    end

    path << @root.value
    path.reverse
  end
end

if __FILE__ == $PROGRAM_NAME
  knight = KnightPathFinder.new([0, 3])
  knight.build_move_tree
  knight.render
  puts
  p knight.find_path([1, 5])
end

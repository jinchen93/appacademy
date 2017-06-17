class BSTNode
  attr_accessor :left, :right, :parent
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end

  def copy_node(node)
    @value = node.value
    @left = node.left
    @right = node.right
  end
end

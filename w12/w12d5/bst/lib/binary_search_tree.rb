# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    new_node = BSTNode.new(value)
    return @root = new_node if @root.nil?

    curr_node = @root
    inserted = false

    until inserted
      if new_node.value > curr_node.value
        # Search on right side of tree
        if curr_node.right.nil?
          new_node.parent = curr_node
          curr_node.right = new_node
          inserted = true
        else
          curr_node = curr_node.right
        end
      else
        # Search on left side of tree
        if curr_node.left.nil?
          new_node.parent = curr_node
          curr_node.left = new_node
          inserted = true
        else
          curr_node = curr_node.left
        end
      end
    end
  end

  def find(value, tree_node = @root)
    result = nil
    found = false
    curr_node = tree_node

    until found
      if value == curr_node.value
        result = curr_node
        found = true
      elsif value > curr_node.value
        # Search right
        if curr_node.right.nil?
          # Terminate the search
          found = true
        else
          curr_node = curr_node.right
        end
      else
        # Search left
        if curr_node.left.nil?
          # Terminate the search
          found = true
        else
          curr_node = curr_node.left
        end
      end
    end

    result
  end

  def delete(value)
    del_node = find(value)

    if del_node.left
      max_node = maximum(del_node.left)
      remove_max_node(max_node)
      del_node.copy_node(max_node)
    elsif del_node.right
      min_node = minimum(del_node.right)
      remove_min_node(min_node)
      del_node.copy_node(min_node)
    else
      return @root = nil if @root == del_node
      del_node.parent.left = nil if del_node.parent.left == del_node
      del_node.parent.right = nil if del_node.parent.right == del_node
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    tree_node = tree_node.right until tree_node.right.nil?
    tree_node
  end

  def minimum(tree_node = @root)
    tree_node = tree_node.left until tree_node.left.nil?
    tree_node
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?

    left_depth = 1 + depth(tree_node.left)
    right_depth = 1 + depth(tree_node.right)

    return left_depth > right_depth ? left_depth : right_depth
  end

  def is_balanced?(tree_node = @root)
    depth(@root.left) - depth(@root.right) == 0
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return if tree_node.nil?

    in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr)

    arr
  end


  private
  # optional helper methods go here:

  def remove_max_node(tree_node)
    if tree_node.left
      tree_node.parent.right = tree_node.left
    else
      tree_node.parent.right = nil
    end
  end

  def remove_min_node(tree_node)
    if tree_node.right
      tree_node.parent.left = tree_node.right
    else
      tree_node.parent.left = nil
    end
  end
end

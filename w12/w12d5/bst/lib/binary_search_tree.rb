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
          curr_node.right = new_node
          inserted = true
        else
          curr_node = curr_node.right
        end
      else
        # Search on left side of tree
        if curr_node.left.nil?
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
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

end

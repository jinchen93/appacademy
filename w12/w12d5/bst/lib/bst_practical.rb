require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  count = 0


  until count == k
    tree_node = tree_node.right until tree_node.right.nil?
    tree_node = tree_node.parent

    count += 1 if tree_node.right
    return tree_node.right if count == k
    count += 1
    return tree_node if count == k
    tree_node = tree_node.left
  end
  nodes[k - 1]
end

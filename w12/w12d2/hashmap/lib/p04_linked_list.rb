class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev && @prev.next = @next
    @next && @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next.nil? && @tail.prev.nil?
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    include = false
    each do |node|
      include = true if node.key == key
    end
    include
  end

  def append(key, val)
    node = Node.new(key, val)
    if empty?
      node.prev = @head
      node.next = @tail
      @head.next = node
      @tail.prev = node
    else
      node.prev = last
      node.next = @tail
      last.next = node
      @tail.prev = node
    end
  end

  def update(key, val)
    each do |node|
      node.val = val if node && node.key == key
    end
  end

  def remove(key)
    each do |node|
      node.remove if node && node.key == key
    end
  end

  def each
    curr_node = @head
    until curr_node == last
      curr_node = curr_node.next
      yield(curr_node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end

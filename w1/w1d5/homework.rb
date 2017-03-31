# Homework for Week 1 Day 5

# First in last out
class Stack
  def initialize
    @stack = []
  end

  def add(el)
    @stack << el
  end

  def remove
    @stack.pop
  end

  def show
    @stack
  end
end

# First in first out
class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue << el
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue
  end
end

# Stores key to single value
class Map
  def initialize
    @map = []
  end

  def assign(key, val)
    pos = find_pos(key)

    if pos.nil?
      @map << [key, val]
    else
      @map[pos][1] = val
    end
  end

  def lookup(key)
    pos = find_pos(key)

    if pos.nil?
      nil
    else
      @map[pos][1]
    end
  end

  def remove(key)
    pos = find_pos(key)
    @map.delete_at(pos)
  end

  def show
    @map
  end

  private

  def find_pos(key)
    @map.index { |ele| ele.first == key }
  end
end

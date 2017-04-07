require_relative 'mystack'

class MinMaxStack
  def initialize
    @store = MyStack.new
  end

  def pop
    @store.pop[:val]
  end

  def push(val)
    @store.push({
      max: get_max(val),
      min: get_min(val),
      val: val
    })
  end

  def empty?
    @store.empty?
  end

  def max
    @store.peek[:max] unless empty?
  end

  def min
    @store.peek[:min] unless empty?
  end

  def peek
    @store.peek[:val] unless empty?
  end

  def size
    @store.size
  end

  private
  def get_max(val)
    return val if empty?
    max > val ? max : val
  end

  def get_min(val)
    return val if empty?
    min < val ? min : val
  end
end


if __FILE__ == $PROGRAM_NAME
  mmstack = MinMaxStack.new
  mmstack.push 1
  mmstack.push 5
  mmstack.push 1
  mmstack.push 10
  mmstack.push 6
  mmstack.push 2
  p mmstack.peek
  p mmstack.max
  p mmstack.min
  p mmstack.pop
  p mmstack.pop
  p mmstack.pop
  p mmstack.max
  p mmstack.min
end

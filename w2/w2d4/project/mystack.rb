class MyStack
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(obj)
    @store << obj
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

if __FILE__ == $PROGRAM_NAME
  stack = MyStack.new
  stack.push 2
  stack.push 20
  stack.push 12
  stack.push 6
  stack.push 1
  p stack.pop
  p stack.pop
  p stack.pop
  p stack.pop
  p stack.pop
  p stack.pop
  p stack.pop
end

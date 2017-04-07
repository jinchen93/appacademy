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

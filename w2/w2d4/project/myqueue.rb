class MyQueue
  def initialize
    @store = []
  end

  def enqueue(obj)
    @store << obj
  end

  def dequeue(obj)
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

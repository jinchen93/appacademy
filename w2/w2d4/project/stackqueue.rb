require_relative 'mystack'

class StackQueue
  def initialize
    @stackin = MyStack.new
    @stackout = MyStack.new
  end

  def enqueue(obj)
    @stackin.push(obj)
  end

  def dequeue
    if @stackout.empty?
      @stackout.push(@stackin.pop) until @stackin.empty?
    end
    @stackout.pop
  end

  def size
    @stackin.size + @stackout.size
  end

  def empty?
    @stackin.empty? && @stackout.empty?
  end
end

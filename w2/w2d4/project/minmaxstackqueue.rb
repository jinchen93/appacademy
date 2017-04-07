require_relative 'minmaxstack'

class MinMaxStackQueue
  def initialize
    @stackin = MinMaxStack.new
    @stackout = MinMaxStack.new
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

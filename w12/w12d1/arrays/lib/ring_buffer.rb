require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise("index out of bounds") if index + 1 > @length
    ring_idx = @start_idx + index
    ring_idx = ring_idx - @capacity if ring_idx >= @capacity
    @store[ring_idx]
  end

  # O(1)
  def []=(index, val)
    ring_idx = @start_idx + index
    ring_idx -= @length if ring_idx >= @length
    @store[ring_idx] = val
  end

  # O(1)
  def pop
    raise("index out of bounds") if @length == 0
    @length -= 1
    ring_idx = @start_idx + @length
    ring_idx -= @capacity if ring_idx > @capacity
    data = @store[ring_idx]
    @store[ring_idx] = nil
    data
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    ring_idx = @start_idx + @length
    ring_idx -= @capacity if ring_idx > @capacity
    @store[ring_idx] = val
    @length += 1
  end

  # O(1)
  def shift
    raise("index out of bounds") if @length == 0
    data = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx += 1
    @length -= 1
    @start_idx = 0 if @start_idx >= @capacity
    data
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx -= 1
    @start_idx = @capacity - 1 if @start_idx < 0
    @length += 1
    @store[start_idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_capacity = @capacity * 2
    new_arr = StaticArray.new(new_capacity)
    @length.times do |n|
      new_arr[n] = self[n]
    end
    @start_idx = 0
    @capacity = new_capacity
    @store = new_arr
  end
end
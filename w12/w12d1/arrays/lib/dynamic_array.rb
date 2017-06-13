require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    raise("index out of bounds") if index + 1 > @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise("index out of bounds") if @length == 0
    @length -= 1
    data = @store[@length]
    @store[@length] = nil
    data
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise("index out of bounds") if @length == 0
    shifted_el = @store[0]
    @length.times do |n|
      if n == @length
        @store[n] = nil
      else
        @store[n] = @store[n + 1]
      end
    end
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    if @length == 0
      @store[0] = val
    else
      prev_el = @store[0]
      @store[0] = val
      (1..@length).each do |n|
        placeholder = @store[n]
        @store[n] = prev_el
        prev_el = placeholder
      end
    end
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_arr = StaticArray.new(@capacity)
    @length.times do |n|
      if @store[n]
        new_arr[n] = @store[n]
      else
        new_arr[n] = nil
      end
    end
    @store = new_arr
  end
end

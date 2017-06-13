require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(2)
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
    @length -= 1
    data = @store[@length]
    @store[@length] = nil
    data
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! unless @store[@length - 1].nil?
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_arr = StaticArray.new(@length * 2)
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

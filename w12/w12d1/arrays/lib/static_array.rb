# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    @store = []
  end

  # O(1)
  def [](index)
    # raise("index out of bounds") if index + 1 > @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  protected
  attr_accessor :store
end

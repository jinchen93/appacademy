class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    resize! if i > @store.length - 1

    if @count < i
      (@count...i).each do |idx|
        @store[idx] = nil unless @store[idx] != nil
        @count += 1
      end
    end

    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    (0...@count).each do |arr_idx|
      return true if @store[arr_idx] == val
    end
    false
  end

  def push(val)
    resize! if @count == @store.length
    @store[count] = val
    @count += 1
  end

  def unshift(val)
    @count += 1
    if @count == @store.length
      new_length = @store.length * 2
      new_arr = StaticArray.new(new_length)
      (0...@count).each do |idx|
        new_arr[idx + 1] = @store[idx]
      end
    else
      new_arr = StaticArray.new(@store.length)
      (0...@count).each do |idx|
        new_arr[idx + 1] = @store[idx]
      end
    end

    new_arr[0] = val
    @store = new_arr
  end

  def pop
    return nil if @count == 0
    val = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    val
  end

  def shift
    @count -= 1
    first_val = @store[0]
    new_arr = StaticArray.new(@store.length)
    (0...@count).each do |idx|
      new_arr[idx] = @store[idx + 1]
    end
    @store = new_arr
    first_val
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each
    (0...@count).each do |idx|
      yield(@store[idx])
    end
  end

  def store
    @store.store
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless @count == other.count

    (0...@count).each do |idx|
      return false unless @store[idx] == other[idx]
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_length = @store.length * 2
    new_arr = StaticArray.new(new_length)

    (0...@store.length).each do |idx|
      new_arr[idx] = @store[idx]
    end

    @store = new_arr
  end
end

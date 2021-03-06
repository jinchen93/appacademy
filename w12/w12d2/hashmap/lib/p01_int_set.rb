class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num > 0 && num < @store.length
  end

  def validate!(num)
    raise("Out of bounds") unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].each_with_index do |el, idx|
      self[num].delete_at(idx) if el == num
    end
  end

  def include?(num)
    include = false
    self[num].each do |el|
      include = true if el == num
    end
    include
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets == @count
    @count += 1
    self[num] << num
  end

  def remove(num)
    @count -= 1
    self[num].each_with_index do |el, idx|
      self[num].delete_at(idx) if el == num
    end
  end

  def include?(num)
    include = false
      self[num].each do |el|
        include = true if el == num
      end
    include
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = @store.length * 2
    new_store = Array.new(new_num_buckets) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_num_buckets] << el
      end
    end
    @store = new_store
  end
end

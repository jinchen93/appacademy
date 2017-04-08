class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true if is_valid?(num)

  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @max
  end

  def validate!(num)
    raise('Out of bounds') unless is_valid?(num)
    raise('Out of bounds') if num < 0
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    if self[num].count == 1
      self[num].delete(num)
    else
      idx_to_delete = nil
      self[num].each_with_index do |el, idx|
        if num == el
          idx_to_delete = idx
          break
        end
      end
      self[num].delete_at(idx_to_delete)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    pos = num % @num_buckets
    @store[pos]
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
    @count += 1
    resize! if @count > num_buckets
    self[num] << num
  end

  def remove(num)
    if include?(num)
      idx_to_delete = nil
      self[num].each_with_index do |el, idx|
        if num == el
          idx_to_delete = idx
          break
        end
      end
      self[num].delete_at(idx_to_delete)

      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    pos = num % num_buckets
    @store[pos]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_array = Array.new(new_num_buckets) { Array.new }
    @store.flatten.each do |el|
      new_pos = el % new_num_buckets
      new_array[new_pos] << el
    end

    @store = new_array
  end
end

require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      idx_to_delete = nil
      self[key].each_with_index do |el, idx|
        if key == el
          idx_to_delete = idx
          break
        end
      end
      self[key].delete_at(idx_to_delete)

      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    pos = num.hash % num_buckets
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

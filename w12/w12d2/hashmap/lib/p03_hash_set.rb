require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    self[key.hash].push(key)
    @count += 1
  end

  def include?(key)
    include = false
    self[key.hash].each do |el|
      include = true if key == el
    end
    include
  end

  def remove(key)
    @count -= 1
    self[key.hash].each_with_index do |el, idx|
      self[key.hash].delete_at(idx) if el == key
    end
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
        new_store[el.hash % new_num_buckets] << el
      end
    end
    @store = new_store
  end
end

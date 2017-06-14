require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    list = bucket(key)
    list.include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    list = bucket(key)
    if include?(key)
      list.update(key, val)
    else
      @count += 1
      list.append(key, val)
    end
  end

  def get(key)
    list = bucket(key)
    return include?(key) ? list.get(key) : nil
  end

  def delete(key)
    list = bucket(key)
    if include?(key)
      @count -= 1
      list.remove(key)
    end
  end

  def each
    @store.each do |list|
      list.each do |node|
        node && yield(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = @store.length * 2
    new_store = Array.new(new_num_buckets) { LinkedList.new }
    each do |k, v|
      new_store[k.hash % new_num_buckets].append(k, v)
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end

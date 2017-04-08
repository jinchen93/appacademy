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
    bucket(key).include?(key)
  end

  def set(key, val)
    pos = key.hash % num_buckets
    if include?(key)
      @store[pos].update(key, val)
    else
      resize! if @count == num_buckets
      @store[pos].append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def get_link(key)
    bucket(key).get_link(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each { |link| prc.call(link.key, link.val) }
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
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) { LinkedList.new }
    @store.flatten.each do |bucket|
      bucket.each do |link|
        new_pos = link.key.hash % new_num_buckets
        new_store[new_pos].append(link.key, link.val)
      end
    end

    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    pos = key.hash % num_buckets
    @store[pos]
  end
end

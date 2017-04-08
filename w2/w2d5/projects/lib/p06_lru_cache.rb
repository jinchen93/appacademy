require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map.get_link(key)
      update_link!(link)
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    eject! if @map.count == @max
    val = @prc.call(key)
    @store.append(key, val)
    @map.set(key, val)
    val
  end

  def update_link!(link)
    key, val = link.key, link.val
    @store.remove(key)
    @store.append(key, val)
  end

  def eject!
    key = @store.first.key
    @store.first.remove
    @map.delete(key)
  end
end

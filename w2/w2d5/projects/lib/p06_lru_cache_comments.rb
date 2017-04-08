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
      # p "HashMap includes key"
      # p @store.map { |l| l.key }
      link = @map.get_link(key)
      # p link
      # p link.next.key
      # p link.prev.key
      # p @map.map { |k, v| [k, v] }
      update_link!(link)
      # p @map.map { |k, v| [k, v] }
      # p @store.map { |l| l.key }
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    eject! if @map.count == @max
    val = @prc.call(key)
    @store.append(key, val)
    @map.set(key, val)
    val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    key, val = link.key, link.val
    @store.remove(key)
    @store.append(key, val)
  end

  def eject!
    key = @store.first.key
    @store.first.remove
    @map.delete(key)
    # p "HashMap"
    # @map.each {|k,v| p "#{k}, #{v}"}
    # p "LinkedList"
    # @store.each {|link| p "#{link.key}, #{link.val}"}
  end
end

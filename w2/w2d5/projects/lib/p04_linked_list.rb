class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    #Ex: 1,2,3, set 1's next to 3, set 3's preve to 1
    @prev.next = @next
    @next.prev = @prev

    #severing ties to other links
    @prev = nil
    @next = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new(:head, nil)
    @tail = Link.new(:tail, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    each { |link| return link.val if link.key == key }
    nil
  end

  def get_link(key)
    each { |link| return link if link.key == key }
    nil
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)

    new_second_to_last = last
    new_second_to_last.next = new_link

    new_link.prev = new_second_to_last
    new_link.next = @tail

    @tail.prev = new_link
  end

  def update(key, val)
    each do |link|
      link.val = val if link.key == key
    end
  end

  def remove(key)
    link_to_remove = nil
    each do |link|
      link_to_remove = link if link.key == key
    end
    link_to_remove.remove
  end

  def each(&prc)
    current_link = first
    until current_link == @tail
      prc.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

if __FILE__ == $PROGRAM_NAME
  list = LinkedList.new
  list.append(1, 1)
  list.append(2, 2)
  p list.to_s
end

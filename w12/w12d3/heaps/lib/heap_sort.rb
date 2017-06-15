require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new

    each do |ele|
      heap.push(ele)
    end

    heap_arr = heap.store

    each_index do |idx|
      self[idx] = heap.extract
    end
    self
  end
end

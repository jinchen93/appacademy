class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || BinaryMinHeap.default_proc
  end

  def count
    @store.length
  end

  def extract
    if @store.length == 4
      @store[2], @store[3] = @store[3], @store[2]
    elsif @store.length == 3
      @store[1], @store[2] = @store[2], @store[1]
    end

    extracted = @store.shift

    child_indices = BinaryMinHeap.child_indices(@store.length, 0)
    swap_child_idx = BinaryMinHeap.find_child_swap_idx(@store, child_indices, &@prc)

    if swap_child_idx && @prc.call(@store[0], @store[swap_child_idx]) > 0
      @store = BinaryMinHeap.heapify_down(@store, 0, &@prc)
    end

    extracted
  end

  def peek
  end

  def push(val)
    idx = @store.length
    @store.push(val)
    return @store if idx == 0

    parent_val = @store[BinaryMinHeap.parent_index(idx)]

    if @prc.call(val, parent_val) < 0
      @store = BinaryMinHeap.heapify_up(@store, idx, &@prc)
    end
  end

  public
  def self.default_proc
    Proc.new do |el1, el2|
      el1 <=> el2
    end
  end

  def self.child_indices(len, parent_index)
    double_len = 2 * parent_index
    first_child = double_len + 1
    second_child = double_len + 2

    if first_child < len && second_child < len
      [first_child, second_child]
    elsif first_child < len && second_child >= len
      [first_child]
    else
      []
    end
  end

  def self.parent_index(child_index)
    raise("root has no parent") if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = prc || BinaryMinHeap.default_proc

    child_indices = BinaryMinHeap.child_indices(len, parent_idx)
    swap_child_idx = BinaryMinHeap.find_child_swap_idx(array, child_indices, &prc)

    return array if swap_child_idx.nil?

    array[parent_idx], array[swap_child_idx] = array[swap_child_idx], array[parent_idx]

    next_idxs = BinaryMinHeap.child_indices(len, swap_child_idx)
    next_swap_idx = BinaryMinHeap.find_child_swap_idx(array, next_idxs, &prc)

    if next_swap_idx && prc.call(array[swap_child_idx], array[next_swap_idx]) > 0
      BinaryMinHeap.heapify_down(array, swap_child_idx, len, &prc)
    else
      array
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = prc || BinaryMinHeap.default_proc

    this_idx = BinaryMinHeap.parent_index(child_idx)

    array[child_idx], array[this_idx] = array[this_idx], array[child_idx]

    return array if this_idx == 0

    parent_idx = BinaryMinHeap.parent_index(this_idx)
    parent_val = array[parent_idx]

    if prc.call(array[this_idx], parent_val) < 0
      BinaryMinHeap.heapify_up(array, this_idx, array.length, &prc)
    else
      array
    end
  end

  def self.find_child_swap_idx(array, idxs, &prc)
    if idxs.empty?
      return nil
    elsif idxs.length == 1
      return idxs.first
    elsif prc.call(array[idxs.first], array[idxs.last]) > 0
      return idxs.last
    else
      return idxs.first
    end
  end
end

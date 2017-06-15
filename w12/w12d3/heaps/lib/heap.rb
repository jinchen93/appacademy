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
    @store.shift
  end

  def peek
  end

  def push(val)
    idx = @store.length
    @store.push(val)
    return @store if idx == 0

    parent_val = @store[BinaryMinHeap.parent_index(idx)]

    if @prc.call(val, parent_val) < 0
      @store = BinaryMinHeap.heapify_up(@store, idx, @prc)
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
    first_child = array[child_indices.first]
    last_child = array[child_indices.last]

    if child_indices.empty?
      swap_child_idx = nil
    elsif child_indices.length == 1
      swap_child_idx = child_indices.first
    elsif prc.call(array[child_indices.first], array[child_indices.last]) > 0
      swap_child_idx = child_indices.last
    else
      swap_child_idx = child_indices.first
    end

    array[parent_idx], array[swap_child_idx] = array[swap_child_idx], array[parent_idx]

    next_idxs = BinaryMinHeap.child_indices(len, swap_child_idx)

    if next_idxs.empty?
      next_swap_idx = nil
    elsif next_idxs.length == 1
      next_swap_idx = next_idxs.first
    elsif prc.call(array[next_idxs.first], array[next_idxs.last]) > 0
      next_swap_idx = next_idxs.last
    else
      next_swap_idx = next_idxs.first
    end

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
end

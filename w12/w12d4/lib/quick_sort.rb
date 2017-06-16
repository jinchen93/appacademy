class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2

    pivot = array[0]
    left = []
    right = []

    array[1...array.length].each do |ele|
      left << ele if ele < pivot
      right << ele if ele >= pivot
    end

    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2

    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    pivot = start

    new_pivot = QuickSort.partition(array, start, length, &prc)

    unless new_pivot == 0
      QuickSort.sort2!(array, new_pivot - 1, array[0..new_pivot - 1].length, &prc)
    end

    unless new_pivot == length - 1
      QuickSort.sort2!(array, new_pivot + 1, array[new_pivot + 1..-1].length, &prc)
    end

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot = array[start]
    split_idx = start

    array[(start + 1)...(length + start)].each_with_index do |ele, idx|
      this_idx = start + idx + 1

      if prc.call(ele, pivot) < 0
        split_idx += 1
        if this_idx > split_idx
          array[this_idx], array[split_idx] = array[split_idx], array[this_idx]
        end
      end
    end

    array[start], array[split_idx] = array[split_idx], array[start]
    split_idx
  end
end
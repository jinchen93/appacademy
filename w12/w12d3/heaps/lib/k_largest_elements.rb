# K-largest elements

# Let's use our BinaryMinHeap to solve a whiteboarding-style question.
# Given an array and an integer k,
# return the k-largest elements in O(k + (n-k)logk) time.

require_relative 'heap'

def k_largest_elements(array, k)
  result = []

  prc = Proc.new do |el1, el2|
    -1 * (el1 <=> el2)
  end

  heap = BinaryMinHeap.new(&prc)
  array.each do |ele|
    heap.push(ele)
  end

  k.times do
    result << heap.extract
  end

  result
end

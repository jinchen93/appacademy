def bad_two_sum?(arr, target_sum) # O(n^2)
  (0...arr.length - 1).each do |first|
    (first + 1...arr.length).each do |second|
      return true if arr[first] + arr[second] == target_sum
    end
  end
  false
end

def okay_two_sum?(arr, target_sum)
  sorted_arr = arr.sort
  found = false
  sorted_arr.each do |el|
    found = true if binary_search(arr, target_sum - el)
  end
  found
end

def binary_search(arr, target)
  return false if arr.empty?
  mid = arr.length / 2
  left = arr[0...mid]
  right = arr[mid + 1..-1]
  if arr[mid] == target
    return true
  elsif arr[mid] < target
    binary_search(right, target)
  else
    binary_search(left, target)
  end
end

if __FILE__ == $PROGRAM_NAME
  p arr = [0, 1, 5, 7]
  p okay_two_sum?(arr, 6) # => should be true
  p okay_two_sum?(arr, 10) # => should be false
end
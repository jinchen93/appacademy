require_relative 'queue'

def window_range(array, window_size)
  current_max_range = nil
  from_end = window_size - 1

  array[0...(array.length - from_end)].each_with_index do |l_val, l_idx|
    sub_arr = array[l_idx...l_idx + from_end]
    min_val = sub_arr.min
    difference = array[l_idx + from_end] - min_val
    if current_max_range.nil?
      current_max_range = difference
    elsif difference > current_max_range
      current_max_range = difference
    end
  end

  current_max_range
end



if __FILE__ === $PROGRAM_NAME
  p window_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
  p window_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
  p window_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
  p window_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
end

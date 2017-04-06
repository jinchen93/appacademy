class Array
  def my_uniq
    new_arr = []
    each do |ele|
      new_arr << ele unless new_arr.include?(ele)
    end
    new_arr
  end

  def two_sum
    new_arr = []
    (0...length - 1).each do |start_idx|
      (start_idx + 1...length).each do |end_idx|
        new_arr << [start_idx, end_idx] if self[start_idx] + self[end_idx] == 0
      end
    end
    new_arr
  end

  def my_transpose
    new_matrix = Array.new(length) { [] }
    (0..(length - 1)).each do |idx|
      each do |row|
        new_matrix[idx] << row[idx]
      end
    end
    new_matrix
  end

end

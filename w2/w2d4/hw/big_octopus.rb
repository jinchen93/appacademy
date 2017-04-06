octopus_array = [
  'fish',
  'fiiish',
  'fiiiiish',
  'fiiiish',
  'fffish',
  'ffiiiiisshh',
  'fsh',
  'fiiiissshhhhhh'
]

def O_times_n_power_2_find_fish(array)
  sorted = false
  until sorted
    sorted = true
    (0...array.length - 1).each do |first_idx|
      (first_idx + 1...array.length).each do |second_idx|
        first_fish = array[first_idx]
        second_fish = array[second_idx]
        if first_fish.length > second_fish.length
          sorted = false
          array[first_idx], array[second_idx] = array[second_idx], array[first_idx]
        end
      end
    end
  end
  array.last
end

def fish_length_merge_sort(array)
  return array if array.length == 1
  middle = array.length / 2
  left = fish_length_merge_sort(array[0...middle])
  right = fish_length_merge_sort(array[middle..-1])
  fish_merge(left, right)
end

def fish_merge(left, right)
  result = []
  until left.empty? || right.empty?
    if left.first.length < right.first.length
      result << left.shift
    else
      result << right.shift
    end
  end
  result + left + right
end

def O_n_log_n_find_fish(array)
  fish_length_merge_sort(array).last
end

def O_n_find_fish(array)
  biggest_fish = array.first
  array.each { |fish| biggest_fish = fish if fish.length > biggest_fish.length }
  biggest_fish
end

tiles_array = [
  "up",
  "right-up",
  "right",
  "right-down",
  "down",
  "left-down",
  "left",
  "left-up"
]

def slow_dance(direction, tiles_array)
  tiles_array.each_with_index do |dir, idx|
    return idx if dir == direction
  end
end

tiles_hash = {
  "up" => 0,
  "right-up" => 1,
  "right" => 2,
  "right-down" => 3,
  "down" => 4,
  "left-down" => 5,
  "left" => 6,
  "left-up" => 7
}

def fast_dance(direction, tiles_hash)
  tiles_hash[direction]
end

def sum_to(n)
  return nil if n < 1
  return n if n == 1
  n + sum_to(n - 1)
end

def add_numbers(nums_array)
  return nums_array.first if nums_array.length <= 1
  nums_array.first + add_numbers(nums_array[1..-1])
end

def gamma_fnc(num)
  return nil if num.zero?
  return num if num == 1
  (num - 1) * gamma_fnc(num - 1)
end

def ice_cream_shop(flavors, favorite)
  return false if flavors.empty?
  return true if flavors.first == favorite
  flavors[0] = ice_cream_shop(flavors[1..-1], favorite)
  flavors[0]
end

def reverse(string)
  return string if string.length <= 1
  reverse(string[1..-1]) + string[0]
end

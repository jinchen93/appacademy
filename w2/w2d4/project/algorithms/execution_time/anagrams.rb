def first_anagram?(str1, str2) # O(n^2 * n!)
  letters = str1.split('')
  variation = my_permutation(letters)
  words = variation.map { |arr_let| arr_let.join('') }
  words.include?(str2)
end

def my_permutation(array)
  return [ [array[0], array[1]], [array[1], array[0]] ] if array.length == 2
  results = []
  array.length.times do
    head = array[0]
    rest = array[1..-1]
    other_permutations = my_permutation(rest)
    other_permutations.each do |sub_arr|
      results << [head] + sub_arr
    end
    array.rotate!
  end
  results
end

def second_anagram?(str1, str2) # O(n^2)
  until str1.empty? # n
    last_char = str1[-1]
    str1.chop!
    if str2.include?(last_char) #n
      index_to_delete = str2.index(last_char)
      str2.slice!(index_to_delete)
    else
      next
    end
  end
  str1.empty? && str2.empty?
end

def third_anagram?(str1, str2) # O(n log n)
  str1.split('').sort == str2.split('').sort
end

def fourth_anagram?(str1, str2) # O(n )
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)
  str1.each_char do |char1|
    hash1[char1] += 1
  end
  str2.each_char do |char2|
    hash2[char2] += 1
  end
  hash1 == hash2
end

if __FILE__ == $PROGRAM_NAME
  p fourth_anagram?("gizmo", "sally")
  p fourth_anagram?("elvis", "lives")
end

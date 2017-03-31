class Array
  def my_each
    for i in (0...self.length)
      yield(self[i])
    end
  end

  def my_select
    arr = []
    self.each do |val|
      arr << val if yield(val)
    end
    arr
  end

  def my_reject
    arr = []
    self.each do |val|
      arr << val unless yield(val)
    end
    arr
  end

  def my_any?
    self.each do |val|
      return true if yield(val)
    end
    false
  end

  def my_flatten
    result = []
    self.each do |val|
      if val.is_a?(Array)
        result += val.my_flatten
      else
        result << val
      end
    end
    result
  end

  def my_zip(*args)
    result = []
    self.each_index do |index|
      entry = []
      entry << self[index]
      args.each do |arr|
        entry << arr[index]
      end
      result << entry
    end
    result
  end

  def my_rotate(distance = 1)
    result = self.dup
    if distance > 0
      distance.times do
        val = result.shift
        result << val
      end
    else
      distance = distance * -1
      distance.times do
        val = result.pop
        result.unshift(val)
      end
    end
    result
  end

  def my_join(separator = "")
    result = ""
    self.each do |val|
      result << val + separator
    end
    result = separator == "" ? result : result[0...-1]
  end

  def my_reverse
    result = []
    for i in ((self.length - 1).downto(0))
      result << self[i]
    end
    result
  end

  def bubble_sort!
    sorted = false
    until sorted == true
      sorted = true
      self.each_with_index do |val, index|
        next if index == self.length - 1
        if block_given?
          comparison = yield(val, self[index + 1])
        else
          comparison = val <=> self[index + 1]
        end
        if comparison == 1
          sorted = false
          self[index], self[index + 1] = self[index + 1], self[index]
        end
      end
    end
    self
  end

  def bubble_sort
    array = self.dup
    array.bubble_sort!
  end
end

def factors(num)
  factors = [1]
  (2..num).each do |val|
    factors << val if num % val == 0
  end
  factors
end

def substrings(string)
  result = []
  (0...string.length).each do |i|
    (i...string.length).each do |j|
      result << string[i..j]
    end
  end
  result
end

def subwords(word, dictionary)
  all_substrings = substrings(word)
  all_words = []
  all_substrings.each do |substring|
    all_words << substring if dictionary.include?(substring)
  end
  all_words
end
# [1,2,3].my_each do |val|
#   puts val * 2
# end

# x = [1,2,3].my_select do |val|
#   val % 2 == 0
# end
# puts x

# x = [1,2,3].my_reject do |val|
#   val % 2 == 0
# end
# puts x

# x = [1,3].my_any? do |val|
#   val.odd?
# end
# puts x
#
# x = [1,3].my_any? do |val|
#   val.even?
# end
# puts x

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
#
# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]

# x = [5,4,3,2,1]
# p x.bubble_sort
# p x
# x.bubble_sort!
# p x

p substrings("cat")
p subwords("cat", ["at","t"])

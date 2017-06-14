require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  counts = Hash.new(0)
  string.each_char do |char|
    counts[char] = counts[char] + 1
  end

  if string.length.odd?
    # Every letter should have even # of occurrences
    # One letter should have odd # of occurences
    num_odd = 0
    counts.each do |_, count|
      num_odd += 1 if count.odd?
    end
    return num_odd == 1
  else
    # Every letter should have even # of occurences
    any_odd = false
    counts.each do |_, count|
      any_odd = true if count.odd?
    end
    return any_odd
  end
end

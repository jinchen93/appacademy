def my_min(list)
  sorted = false
  until sorted
    sorted = true
    (0...list.length - 1).each do |starting|
      (starting + 1...list.length).each do |ending|
        if list[starting] > list[ending]
          sorted = false
          list[starting], list[ending] = list[ending], list[starting]
        end
      end
    end
  end
  list[0]
end

def my_min_fast(list)
  smalest = list[0]
  list.each do |val|
    smalest = val if val < smalest
  end
  smalest
end

list = [2, 3, -6, 7, -6, 7]

def largest_contiguous_sum_slow(list)
  sub_arr = []
  (0...list.length).each do |start| # n
    (start...list.length).each do |ended| # n
      sub_arr << list[start..ended]
    end
  end

  curent_largest = sub_arr[0]
  sub_arr[1..-1].each do |el|
    if el.inject(:+) > curent_largest.inject(:+)
      curent_largest = el
    end
  end

  curent_largest.inject(:+)
end

list = [2, 3, -6, 7, -6, 7]

def largest_contiguous_sum_fast(list)
  max = list[0]
  max_ending = list[0]
  list[1..-1].each do |val|
    if max_ending + val > val
      max_ending += val
    else
      max_ending = val
    end
    if max_ending > max
      max = max_ending
    end
  end
  max
end

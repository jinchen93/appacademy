class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    chars = self.join(',').chars
    #accounts for [5,7,5,1] and [57,51]
    chars_wo_comma = chars.map do |char|
      if char == ','
        '1'
      else
        char
      end
    end

    arr_to_fixnum = chars_wo_comma.join('').to_i
    arr_to_fixnum.hash
  end
end

class String
  def hash
    ascii_arr = []
    self.each_byte do |byte|
      ascii_arr << byte
    end
    ascii_arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.to_a.flatten

    arr_no_symbols = arr.map do |ele|
      if ele.is_a?(Symbol)
        ele.to_s
      else
        ele
      end
    end

    #sort is breaking rspec
    
    # arr_no_strings = arr_no_symbols.sort.map do |ele|
    #   ele.hash if ele.is_a?(String)
    # end

    #
    # arr_no_strings.hash
    0
  end
end

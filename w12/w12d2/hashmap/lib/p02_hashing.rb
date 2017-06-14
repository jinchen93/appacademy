class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed = length.hash
    each_with_index do |ele, idx|
      if ele
        hashed += (ele * idx).hash
      end
    end
    hashed
  end
end

class String
  def hash
    hashed = length.hash
    each_char.with_index do |char, idx|
      ascii_code = char.ord
      hashed += (ascii_code +  idx).hash
    end
    hashed
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = length.hash
    each do |k, v|
      hashed += (k.hash + v.hash)
    end
    hashed
  end
end

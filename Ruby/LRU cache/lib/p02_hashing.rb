class Integer
  # Integer#hash already implemented for you
end

# assuming dealing only with integers, strings and symbols
class Array
  def hash
    key = 0
    self.each_with_index do |e, i|
      key += (e ^ i).hash
    end
    key.hash
  end
end

class String
  def hash
    self.split('').map(&:ord).hash
  end
end

class Hash
  
  def hash
    hash_arr = self.to_a.sort.flatten 
    hash_arr.map! do |el|
      if el.is_a?(String)
        el.ord 
      elsif el.is_a?(Symbol)
        str = el.to_s
        str.ord ^ str.to_i(16)
      else  # it is integer
        el
      end
    end
    hash_arr.hash
  end
end

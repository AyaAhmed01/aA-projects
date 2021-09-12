class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    # calls resize! when enough elements are inserted
    resize! if count == num_buckets
    return if self.include?(key)
    self[key.hash] << key
    @count += 1
  end

  def remove(key)
    return unless self.include?(key)
    self[key.hash].delete(key)
    @count -= 1
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store
    k = num_buckets * 2
    @store = Array.new(k) { Array.new }
    temp.each do |bucket|
      bucket.each do |ele|
        self[ele.hash] << ele  
      end
    end
  end
end

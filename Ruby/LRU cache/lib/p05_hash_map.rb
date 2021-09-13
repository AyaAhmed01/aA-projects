require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.any?{|k, v| k == key}
  end

  def set(key, val)
    resize! if count == num_buckets
    bucket = bucket(key.hash)
    if bucket.include?(key)
      bucket.update(key, val) 
    else
      bucket.append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key.hash).get(key)
  end

  def delete(key)
    @count -= 1 if bucket(key.hash).remove(key)
  end

  include Enumerable
  def each(&prc)
    # method should yield [key, value] pairs.
    @store.each do |bucket|
      bucket.each do |node|
        prc.call([node.key, node.val])
      end
    end
    nil 
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store
    @store = Array.new(num_buckets * 2){LinkedList.new} 
    temp.each do |ll|
      ll.each do |node|
        bucket(node.key.hash).append(node.key, node.val)
      end
    end
  end

  def bucket(key)
    # return the bucket corresponding to `hashed_key`
    @store[key % num_buckets]
  end
end

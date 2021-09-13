class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # connects previous link to next link
    # and removes self from list.
    prev.next = self.next 
    self.next.prev = prev 
  end
end

class LinkedList
  def initialize
    @head = Node.new
    @tail = Node.new 
    @head.next = @tail 
    @tail.prev = @head 
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next 
  end

  def last
    @tail.prev 
  end

  def empty?
    @head.next == @tail  
  end

  def get(key)
    self.each do |node| 
      return node.val if node.key == key
    end
  end

  def include?(key)
    self.any?{|node| node.key == key}
  end

  def append(key, val)
    node = Node.new(key, val)
    node.next = @tail 
    node.prev = @tail.prev
    @tail.prev.next = node
    @tail.prev = node
  end

  def update(key, val)
    self.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key 
        node.prev.next = node.next
        node.next.prev = node.prev
        return
      end
    end
  end

  include Enumerable
  def each(&prc)
    node = @head 
    until node.next == @tail 
      node = node.next 
      prc.call(node) 
    end
    nil
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

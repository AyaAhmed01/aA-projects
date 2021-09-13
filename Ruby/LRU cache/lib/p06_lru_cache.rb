require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # see if exist: put node at last of LL (update_node), return it
    # if does not: make val (calc!), push (k, v) to end of LL, make (key, val) in hash 
    # and val is a pointer to node.
    # see if LL is at max: eject!
    if @map.include?(key) 
      update_node!(@map[key])
      node = @store.last
      @map[key] = node     # should reassign as update_node! uses LL#append that makes new object
    else
      val = calc!(key)
      node = @store.append(key, val) 
      @map.set(key, node)
      eject! if count > @max  
    end
    return node.val 
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # move a node to the end of the list (making NEW node with same key, val)
    @store.remove(node.key)
    @store.append(node.key, node.val)
  end

  def eject!
    # delete the first item in your linked list, and delete that key from hash
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
  end
end

# This is for just how queue works, MyQueue is not used in implementation
class MyQueue
    def initialize
      @store = []
    end

    def peek 
        @store.first
    end

    def size 
        @store.length
    end

    def empty?
        @store.empty?
    end

    def enqueue(ele)
        @store << ele
    end

    def dequeue
        @store.shift  # O(n)
    end
end

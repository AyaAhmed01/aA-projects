class MyStack
    def initialize
      @store = []
    end

    def peek 
        @store[-1]
    end

    def size 
        @store.length
    end

    def empty?
        @store.empty?
    end

    def pop 
        @store.pop 
    end

    def push(ele)
        @store << ele 
    end
end

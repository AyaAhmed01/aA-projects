# Just to know how MinMaxStackQueue works, StackQueue is not used in implementation
class StackQueue
    def initialize
      @in_stack = MyStack.new 
      @out_stack = MyStack.new 
    end

    def size 
        @in_stack.size + @out_stack.size 
    end

    def empty?
        @in_stack.empty? && @out_stack.empty? 
    end

    def dequeue
        queuefiy if @out_stack.empty?
        @out_stack.pop
    end

    def enqueue(ele)
        @in_stack.push(ele)
    end

    def queuefiy
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end
end
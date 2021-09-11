require_relative '04_minMax_stack'
class MinMaxStackQueue
    def initialize
        @in_stack = MinMaxStack.new 
        @out_stack = MinMaxStack.new 
    end

    def empty?
        @in_stack.empty? && @out_stack.empty?
    end

    def size 
        @in_stack.size + @out_stack.size 
    end

    def dequeue
        queuefiy if @out_stack.empty?
        # If we haven't already reversed the stack, this runs in O(n). However, we
        # only have to do this once for every n dequeue operations, so it amortizes
        # to O(1)
        @out_stack.pop
    end

    def enqueue(ele)          # O(1)
        @in_stack.push(ele)
    end

    def queuefiy
        # How do you turn a stack into a queue? Flip it upside down.
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end

    def min 
        minis = []
        minis << @in_stack.min unless @in_stack.empty?
        minis << @out_stack.min unless @out_stack.empty?
        minis.min 
    end

    def max
        maxis = []
        maxis << @in_stack.max unless @in_stack.empty?
        maxis << @out_stack.max unless @out_stack.empty?
        maxis.max 
    end
end


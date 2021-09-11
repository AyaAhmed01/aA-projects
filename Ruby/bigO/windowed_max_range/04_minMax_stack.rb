class MinMaxStack 

    def initialize
        @store = []
        @min = nil 
        @max = nil 
        @min_max = {}
        populate_minmax
    end

    def populate_minmax
        if @min_max.has_key?(@store)
            @min = @min_max[@store][:mn]
            @max = @min_max[@store][:mx]
            return
        end
        @min_max[@store] = {mn: @min , mx: @max}
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

    attr_reader :min, :max 
    def pop 
        ele = @store.pop 
        populate_minmax
        ele 
    end

    def push (ele)
        @min = ele if min.nil? || ele < min  
        @max = ele if max.nil? || ele > max 
        @store.push(ele)
        populate_minmax
    end
  end

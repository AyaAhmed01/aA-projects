require 'colorize' 

class Title
    attr_reader :value 
    def initialize (val)    
        @value = val
        @given = (val == 0 ? false : true)
    end

    def value=(new_val)
        if @given
             puts "Given values can NOT be changed.."
             false 
        else
            @value = new_val
        end
    end

    def given?
        @given
    end

    def color 
        given? :red : :blue
    end

    def to_s     
         value == 0? " " : value.to_s.colorize(color) # as long as value still 0, put it ' '.
    end                                              # when set to value make it blue. if given make it red
end

# t = Title.new(0)
# t.value 
# t.value = 5   # not allowed
# t.to_s
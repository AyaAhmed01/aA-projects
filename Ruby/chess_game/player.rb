class Player
    attr_reader :color
    def initialize (color, display)
        @color, @display = color, display
    end

    protected
    attr_reader :display
end
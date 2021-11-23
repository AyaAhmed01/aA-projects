class Player 
    attr_reader :name 
    def initialize (name)
        @name = name
    end

    def guess
        puts "#{@name}, guess a letter to add to fragment.."
        gets.chomp
    end

    def alert_invalid_guess
    end
end
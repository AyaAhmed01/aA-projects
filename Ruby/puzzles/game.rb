require_relative 'board.rb'

class Game

    def self.from_file(file)
        board = Board.from_file(file)
        self.new(board)
    end

    def initialize(board)
        @board = board
    end

    def play
        until board.solved?
            board.render
            get_input
        end

        puts "Congratulations, you win!"
    end

    def prompt
        puts "Please enter a position and value to update (i.e 4,5 1)"
    end

    def get_input
        pos = nil
        val = nil
        until pos && valid_input?(pos, val)
            prompt
            pos, val = gets.chomp.split(' ')
            val = val.to_i 
            pos = pos.split(',').map(&:to_i)
        end
        update(pos, val)
    end

    def update(pos, val)
        board[pos] = val 
    end

    def valid_input?(pos, val)
        pos.is_a?(Array) && pos.length == 2 && val.is_a?(Integer) &&
        pos.all?{|i| i.between?(0, 8)}  && val.between?(1, 9)
    end

    private
    attr_reader :board
end
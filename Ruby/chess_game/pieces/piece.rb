require 'byebug'
class Piece 
    attr_reader :board, :color
    attr_accessor :pos
    def initialize(board, pos, color)
        @pos , @board, @color = pos, board, color
        @symbol
    end

    def moves 
        #overwritten by subclass 
        raise NotImplementedError
    end

    def empty? 
        false  
    end

    def valid_moves
        moves.reject{|pos| move_into_check?(pos)}
    end

    def symbol
        @symbol
    end

    private
    def move_into_check?(end_pos)   # see if after this move MY king will be in check
        temp_board = board.dup 
        temp_board.move_piece!(pos, end_pos)
        temp_board.in_check?(color)
    end
end
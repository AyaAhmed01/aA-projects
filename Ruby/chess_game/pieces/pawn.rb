require_relative 'piece'
require 'byebug'
class Pawn < Piece
    def initialize(board, pos, color)
        super
        @symbol = :P 
    end

    def moves  # return array of possible next positions 
        forward_steps + side_attacks
    end

    private
    def at_start_row?
        (color == :blue && pos[0] == 1)  || (color == :yellow && pos[0] == 6) 
    end

    def forward_dir  # returns 1 for blue, -1 for yellow
        return (color == :blue ? 1 : -1)
    end

    def forward_steps
        moves = []
        cur_x, cur_y = pos 
        if board.empty?([cur_x + forward_dir, cur_y])
            moves << [cur_x + forward_dir, cur_y]
            moves << [cur_x + 2 * forward_dir, cur_y] if board.empty?([cur_x + 2*forward_dir, cur_y]) &&
            at_start_row?
        end
        moves
    end

    def side_attacks
        moves = [[pos[0] + forward_dir, pos[1] + 1], [pos[0] + forward_dir, pos[1] - 1]]
        moves.select do |new_pos|
            next false unless board.valid_pos?(new_pos) 
            next false if board.empty?(new_pos)
            captured_piece = board[new_pos]
            captured_piece.color != color
        end 
    end
end


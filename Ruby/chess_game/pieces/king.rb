require_relative 'piece'
require_relative 'stepable'
class King < Piece
    include Stepable
    def initialize(board, pos, color)
        super
        @symbol = :King
    end

    private
    def move_diffs
        [[-1, 0],
         [1, 0],
         [0, -1],
         [0, 1],
         [-1, -1],
         [1, 1]
        ]
    end
end


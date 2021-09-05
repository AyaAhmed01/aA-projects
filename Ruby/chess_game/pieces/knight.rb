require_relative 'piece'
require_relative 'stepable'
class Knight < Piece
    include Stepable
    def initialize(board, pos, color)
        super
        @symbol = :K
    end

    private
    def move_diffs
        [[-2, 1],
         [-1, 2],
         [1, 2],
         [2, 1],
         [-1, -2],
         [-2, -1],
         [1, -2],
         [2, -1]
        ]
    end
end
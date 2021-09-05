require_relative 'piece'
require_relative 'slideable'
class Rook < Piece
    include Slideable
    def initialize(board, pos, color)
        super
        @symbol = :R 
    end

    protected
    def move_dirs
        horizontal_and_vertical_dirs
    end
end

require 'singleton'
require_relative 'piece'
class NullPiece < Piece
    include Singleton 
    def initialize 
        @color = :none
        @symbol = :O 
    end

    def empty?
        true
    end

    def moves 
        []
    end
end

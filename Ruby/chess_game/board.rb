require_relative 'pieces'
require 'byebug'
class Board
    attr_reader :rows 

    def init_board(fill_board)
        board = Array.new(8){Array.new(8, nullPiece)}
        if fill_board
            board[0] = make_back_row(:blue)     # I used blue/yellow colors instead of white/black to be visible on CLI
            board[7] = make_back_row(:yellow)
            board[1] = make_pawn_row(:blue)
            board[6] = make_pawn_row(:yellow)
        end
        board
    end

    def make_back_row(color)
        pieces_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        back_row = []
        i = (color == :blue ? 0 : 7)
        pieces_classes.each_with_index do |piece_class, j|
            back_row << piece_class.new(self, [i, j], color)
        end
        back_row
    end

    def make_pawn_row(color)
        r = (color == :blue ? 1 : 6)
        row = []
        8.times{ |c| row << Pawn.new(self,[r, c], color)}
        row 
    end

    def initialize(fill_board = true)
        @nullPiece = NullPiece.instance
        @rows = init_board(fill_board)
    end

    def [](pos)
        raise "Invalid position" unless valid_pos?(pos)
        r,c = pos 
        rows[r][c]
    end

    def []=(pos, piece)
        raise "Invalid position" unless valid_pos?(pos)
        r, c = pos 
        rows[r][c] = piece 
    end

    
    def move_piece (turn_color, start_pos, end_pos)
        piece = self[start_pos]
        raise RuntimeError.new("start position #{start_pos} is empty..") if empty?(start_pos)
        raise RuntimeError.new("You can only move your own pieces") if piece.color != turn_color
        raise RuntimeError.new("This move #{end_pos} is not allowed for #{piece.symbol}.") unless piece.moves.include?(end_pos)
        raise RuntimeError.new("You can not move into check") unless piece.valid_moves.include?(end_pos)
        move_piece!(start_pos, end_pos)
    end

    #moves piece without checking in_check? .. called in piece class
    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]
        self[end_pos] = piece 
        piece.pos = end_pos
        self[start_pos] = nullPiece
    end

    def valid_pos?(pos)
        pos.all?{|i| i.between?(0, 7)}
    end

    def empty?(pos)
        self[pos].empty?
    end

    def check_mate?(color)
        return false unless in_check?(color)
        player_pieces = pieces(color)
        player_pieces.all?{|piece| piece.valid_moves.empty?}
    end

    def pieces (color)        
        rows.flatten.select{|piece| piece.color == color}
    end

    def in_check?(color)
        king_pos = find_king(color)
        if color == :blue
            opponent_pieces = pieces(:yellow)
        else
            opponent_pieces = pieces(:blue)
        end
        opponent_pieces.any?{|piece| piece.moves.include?(king_pos)}
    end

    def find_king (color)
        rows.flatten.each do |piece|
            return piece.pos if piece.color == color && piece.symbol == :K 
        end
        nil 
    end

    def dup_row!(row,i, new_board)     # fill a row in duplicate board
        rows[i].each_with_index do |piece, piece_idx|
            row[piece_idx] = piece.class.new(new_board, piece.pos, piece.color) unless piece.empty?
        end
    end

    def dup      # returns a duplicate board of current board
        new_board = Board.new(false)    # creates board of nullPieces
        new_board.rows.each_with_index {|new_row, i| dup_row!( new_row, i, new_board)}
        new_board
    end

    private
    attr_reader :nullPiece
end


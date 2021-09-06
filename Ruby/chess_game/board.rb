require_relative 'pieces'
require 'byebug'
class Board
    
    def init_board(full_board)
        board = Array.new(8){Array.new(8, nullPiece)}
        if full_board
            board[0] = make_back_row(:white)
            board[7] = make_back_row(:black)
            board[1] = make_pawn_row(:white)
            board[6] = make_pawn_row(:black)
        end
        board
    end

    def make_back_row(color)
        pieces_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        back_row = []
        i = (color == :white ? 0 : 7)
        pieces_classes.each_with_index do |piece_class, j|
            back_row << piece_class.new(self, [i, j], color)
        end
        back_row
    end

    def make_pawn_row(color)
        r = (color == :white ? 1 : 6)
        row = []
        8.times{ |c| row << Pawn.new(self,[r, c], color)}
        row 
    end

    def initialize(full_board = true)
        @nullPiece = NullPiece.instance
        @rows = init_board(full_board)
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
        raise "You can only move your own pieces" if piece.color != turn_color
        raise "start position #{start_pos} is empty.." if empty?(start_pos)
        raise "This move is not allowed #{end_pos}.." unless piece.moves.include?(end_pos)
        raise "You can not move into check" unless piece.valid_moves.include?(end_pos)
        move_piece!(start_pos, end_pos)
    end

    #moves piece without checking in_check? .. used in piece class
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
        if color == :white
            opponent_pieces = pieces(:black)
        else
            opponent_pieces = pieces(:white)
        end
        # opponent_pieces = pieces(color == :white? :black : :white)
        opponent_pieces.any?{|piece| piece.moves.include?(king_pos)}
    end

    def find_king (color)
        rows.flatten.each do |piece|
            return piece.pos if piece.color == color && piece.symbol == :King 
        end
        nil 
    end

    def dup_row!(row,i, new_board)
        rows[i].each_with_index do |piece, p_i|
            row[p_i] = piece.class.new(new_board, piece.pos, piece.color) unless piece.empty?
        end
    end

    def dup 
        new_board = Board.new(false)    # creates board of nullPieces
        new_board.rows.each_with_index {|new_row, i| dup_row!( new_row, i, new_board)}
        new_board
    end

    
    attr_reader :rows
    private
    attr_reader :nullPiece
end

# b = Board.new 

# b.move_piece(:white, [1, 4], [3, 4])

# b.rows.each do |row|
#     p row.map(&:symbol)
# end
# puts

# b.move_piece(:black, [6, 5], [5, 5])

# b.rows.each do |row|
#     p row.map(&:symbol)
# end
# puts
# b.move_piece(:black, [6 , 6], [4, 6])

# b.rows.each do |row|
#     p row.map(&:symbol)
# end
# puts
# b.move_piece(:white, [0, 3], [4, 7])

# b.rows.each do |row|
#     p row.map(&:symbol)
# end
# puts

# p b.check_mate?(:black)


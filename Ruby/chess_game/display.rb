require 'colorize'
require 'byebug'
require_relative 'cursor'
require_relative 'board'
class Display
    attr_reader :board, :cursor
    def initialize (board)
        @board, @cursor = board, Cursor.new([0, 0], board)
    end

    def build_grid
        board.rows.map.with_index do |row, i|
            build_row(row, i)
        end
    end
    
    def build_row(row, i)
        row.map.with_index do |piece, j|
            color_style = piece_color(i , j)
            piece.to_s.colorize(color_style)
        end
    end
    
      def piece_color(i, j)
        if cursor.selected && cursor.cursor_pos == [i, j]
            bg = :light_red 
        elsif cursor.selected
            bg = :light_green
        elsif board[[i, j]].color == :white 
            bg = :light_blue
        elsif board[[i, j]].color == :black 
            bg = :light_yellow
        else
            bg = :light_white
        end
        {background: bg}
      end
    
      def render
        system("clear")
        puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
        build_grid.each { |row| puts row.join('') }
      end

      def Test
        7.times do  
            render
            cursor.get_input
        end
      end
end

# Render the square at the @cursor_pos display in a different color. 
# Test that you can move your cursor around the board by creating and calling a method 
# that loops through Display#render and Cursor#get_input (much as Player#make_move will
#  function later!).

# b = Board.new 
# dis = Display.new(b)
 
# dis.Test
require_relative 'player'
class HumanPlayer < Player
    
    def make_move(board) 
        start_pos, end_pos = nil, nil 
        until start_pos && end_pos
            display.render
            user_input = nil 
            until user_input
                if start_pos.nil?
                    puts "It is #{color} turn. Move from where?" 
                elsif start_pos
                    puts "It is #{color} turn. Move to where?"
                end
                user_input = display.cursor.get_input 
                display.render
            end
            if display.cursor.selected 
                start_pos = user_input
            else
                end_pos = user_input
            end
        end
        board.move_piece(color, start_pos, end_pos)
    end

end
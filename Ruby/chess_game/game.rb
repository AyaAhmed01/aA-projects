require_relative 'board'
require_relative 'display'
require_relative 'humanPlayer'

class Game
    
    def initialize 
        @board = Board.new
        @display = Display.new(board)
        @players = [HumanPlayer.new(:blue, @display),  HumanPlayer.new(:yellow, @display)] 
        @current_player = players.first
    end

    def play   
        until board.check_mate?(current_player.color)
            begin
            current_player.make_move(board)
            rescue => e 
                notify_players(e)
                retry
            end
            swap_turn!
        end
        puts ("Checkmate! #{current_player.color} kingdom has fallen!")
    end

    private
    def swap_turn!
        players.push(players.shift)
        @current_player = players.first 
    end

    def notify_players(error)   #handle exeptions from move_piece
        puts error.message 
        sleep(1)
    end
    attr_reader :players, :board, :current_player
end

g = Game.new 
g.play 
require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    not_losing_node = nil 
    node.children.each do |child_node|
      return child_node.prev_move_pos if child_node.winning_node?(mark)
      not_losing_node = child_node unless child_node.losing_node?(mark)
    end
    raise "Game is Not perfect! you can not win or make a draw" if not_losing_node.nil?
    not_losing_node.prev_move_pos
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end

require_relative 'tic_tac_toe'
require 'byebug'
class TicTacToeNode
  
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos = 
    board, next_mover_mark, prev_move_pos
  end

  def losing_node?(evaluator)  
    opponent_evaluator = ((evaluator == :x) ? :o : :x)
    if board.over?   # a tie or won
      return true if board.winner == opponent_evaluator 
      return false   # tie is ( !loss )  
    end

    child_nodes = children 
    # player's turn
    return child_nodes.all?{ |node| node.losing_node?(evaluator)} if next_mover_mark == evaluator 
    # opponent's turn  
    return child_nodes.any?{ |node| node.losing_node?(evaluator)} if next_mover_mark == opponent_evaluator
  end

  def winning_node?(evaluator)
    opponent_evaluator = ((evaluator == :x) ? :o : :x)
    if board.over?
      return board.winner == evaluator                 # tie is NOT a winning
    end

    child_nodes = children 
    # player's turn
    return child_nodes.any?{ |node| node.winning_node?(evaluator) } if next_mover_mark == evaluator 
    # opponent's turn  
    return child_nodes.all?{ |node| node.winning_node?(evaluator) } if next_mover_mark == opponent_evaluator
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |i|
      (0..2).each do |j|
        next unless board.empty?([i, j])
        child_board = board.dup 
        child_board [[i, j]] = next_mover_mark
        children << TicTacToeNode.new(child_board, ((next_mover_mark == :x) ? :o : :x) , [i, j])
      end
    end
    children
  end

end


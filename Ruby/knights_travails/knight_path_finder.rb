require_relative 'polyTreeNode.rb'
require 'byebug'

class KnightPathFinder

    def self.valid_moves (init_pos) # gives the possible 8 move positions from init_pos
        nodes = []
        x, y = init_pos
        dx = [-1, -2, -2, -1, 1, 2, 2 , 1]
        dy = [-2, -1, 1, 2, -2, -1, 1, 2]
        (0..7).each do |i|
            nx = x + dx[i]
            ny = y + dy[i]
            nodes << PolyTreeNode.new([nx, ny]) if KnightPathFinder.valid_pos? ([nx, ny])
        end
        nodes
    end

    def self.valid_pos?(pos)
        x, y = pos 
        x >= 0 && x < 8 && y >= 0 && y < 8
    end

    def initialize(start_pos)
        # debugger
        @root_node = PolyTreeNode.new(start_pos)
        @visited_positions = [@root_node.value]
        build_move_tree
    end

    def build_move_tree  # builds the move tree starting from root_node using new_move_positions in BFS
        queue = [root_node]

        while(!queue.empty?)
            curr_node = queue.shift
            new_positions = new_move_positions(curr_node.value)
            curr_node.children.concat(new_positions)
            queue.concat(new_positions)
            visited_positions.concat(new_positions.map(&:value))
        end
    end

    def new_move_positions(pos)    # takes the positions from ::valid_moves, then filter out the visited ones
        KnightPathFinder.valid_moves(pos).select{|node| !visited_positions.include?(node.value)}  
    end

    attr_reader :visited_positions, :root_node
end

# kpf = KnightPathFinder.new([0, 0])
# kpf.root_node.children.each do |child_node|
#     p child_node.children.map(&:value)
#     puts "-------------"
# end
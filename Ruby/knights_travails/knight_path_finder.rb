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
        pos.all?(&:between(0, 7))
    end

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @visited_positions = [@root_node.value]
        build_move_tree
    end

    def build_move_tree  # builds the move tree starting from root_node using new_move_positions in BFS
        queue = [root_node]

        while(!queue.empty?)
            curr_node = queue.shift
            new_children = new_move_positions(curr_node.value)
            new_children.each {|child| curr_node.add_child(child)}
            queue.concat(new_children)
            visited_positions.concat(new_children.map(&:value))
        end
    end

    def new_move_positions(pos)    # takes the positions from ::valid_moves, then filter out the visited ones
        KnightPathFinder.valid_moves(pos).select{|node| !visited_positions.include?(node.value)}  
    end

    def find_path(end_pos)  
        end_node = root_node.bfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(node)
        return [node.value] if node.parent.nil?
        trace_path_back(node.parent) + [node.value]
    end

    attr_reader :visited_positions, :root_node
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]

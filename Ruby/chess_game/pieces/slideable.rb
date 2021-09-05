module Slideable
    HORIZONTAL_AND_VERTICAL_DIRS = [
        [0, 1],
        [0, -1],
        [1, 0],
        [-1, 0]
    ]
    DIAGONAL_DIRS = [
        [1,1],
        [-1, 1],
        [-1, -1],
        [1, -1]
    ]

    def horizontal_and_vertical_dirs     # including module, gives no access to Constants inside. So make this getters
        HORIZONTAL_AND_VERTICAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def move_dirs
        #overwritten by subclasses
        raise NotImplementedError 
    end

    def moves 
        moves = []
        move_dirs.each do |dx, dy|
            moves.concat(grow_unblocked_moves_in_dir(dx, dy))
        end
        moves 
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        moves = []
        cur_x, cur_y = pos 
        loop do 
            cur_x, cur_y = cur_x + dx , cur_y + dy
            new_pos = [cur_x, cur_y]
            break unless board.valid_pos?(new_pos)
            if board.empty?(new_pos)
                moves << new_pos 
            else
                # add to moves if opponent occupies it
                moves << new_pos if board[new_pos].color != color 
                break 
            end
        end
        moves 
    end
end
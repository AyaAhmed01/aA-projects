module Stepable
    def moves 
        moves = []
        move_diffs.each do |dx, dy|
            new_x, new_y = pos[0] + dx, pos[1] + dy 
            next if board[[new_x,new_y]].color == color
            moves << [new_x, new_y]
            rescue                   # when pos is invalid
                next 
        end
        moves 
    end

    private
    def move_diffs
        #overwritten by subclass
        raise NotImplementedError
    end
end
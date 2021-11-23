require_relative 'title.rb'

class Board

    #factory method:
    def self.from_file(file) 
        rows = File.readlines(file).map(&:chomp)
        grid = Array.new(rows.length) {[]}
        rows.each_with_index do |row, row_i|
            nums = row.split("").map(&:to_i)
            nums.each {|i| grid[row_i] << Title.new(i)}
        end
        self.new(grid)            # make them call each other, so I only call from_file  to initialize
    end

    attr_reader :grid 
    def initialize (grid)
        @grid = grid
    end

    def [](pos)
        row, col = pos
        grid[row][col]
    end

    def []= (pos, val)
        title = self[pos]
        title.value = val 
    end

    def render
        system("clear")
        grid.each do |row|
            puts row.map(&:to_s).join(' ')
        end
    end

    def solved?
        columns.all?{|col| solved_set?(col)} &&
        rows.all?{|row| solved_set?(row)} &&
        squares.all?{|square| solved_set?(square)}

        puts columns.all?{|col| solved_set?(col)}
        puts rows.all?{|row| solved_set?(row)}
        puts squares.all?{|square| solved_set?(square)}
    end

    def rows
        grid 
    end

    def columns
        rows.transpose
    end

    def squares
        (0..8).to_a.map{|i| square(i)}
    end

    def square(idx)
        tiles = []
        x = (idx / 3) * 3
        y = (idx % 3) * 3
        (x...x+3).each do |i|
            (y...y+3).each do |j|
                tiles << self[[i, j]]
            end
        end
        tiles 
    end

    def solved_set?(tiles)
        tiles.map(&:value).sort == (1..9).to_a 
    end
end

# grid = Board.from_file("test.txt")
# b = Board.new(grid)
# b[[1,1]] =  5  #not
# b[[0, 0]] = 4
# b[[2, 0]] =  2
# b[[2, 1]] =  1
# b.solved?

# 0312
# 1234
# 0043
# 3421
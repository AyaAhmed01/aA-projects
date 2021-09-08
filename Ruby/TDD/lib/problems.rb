class Array
    def uniq
        uniq_arr = []
        self.each do |e|
            uniq_arr << e unless uniq_arr.include?(e)
        end
        uniq_arr
    end

    def two_sum
        dic = {}
        self.each_with_index do |ele1, i|
            self.each_with_index  do |ele2, j|
                dic[i] = j if ele1 + ele2 == 0 && !dic.values.include?(i) && i != j
            end
        end
        ans = []
        dic.each do |k, v|
            ans << [k, v]
        end
        ans 
    end
end

# assume square arrays
def my_transpose(arr)
    ans = Array.new(arr.length){Array.new(arr[0].length)}
    arr.each_with_index do |row, i|
        row.each_with_index do |ele, j|
            ans[j][i] = ele 
        end
    end
    ans 
end

def stock_prices(prices)
    best_buy, best_sell = 0, 0
    (0...prices.length).each do |buy|
        (buy...prices.length).each do |sell|
            if prices[sell] - prices[buy] > prices[best_sell] - prices[best_buy]
                best_buy , best_sell = buy, sell 
            end
        end
    end
    [best_buy, best_sell]
end

require 'byebug'
class Disc 
    attr_reader :size
    def initialize(size)
        @size = size 
    end
end

class Hanoi
    attr_reader :piles, :size 
    def initialize(num_of_discs = 3)
        @size = num_of_discs
        @piles = Array.new(3){[]}
        init_piles
    end

    def init_piles
        (1..size).each do |i|
            piles[0] << Disc.new(i) 
        end 
    end

    def play 
        until won?
            begin
            render
            from, to = prompt
            move(from, to)
            rescue => e 
                puts "#{e.message}"
                retry
            end
        end
        puts "Great job! all discs are moved"
    end

    def render 
        piles.each_with_index do |pile, i|
            puts "Tower #{i}: #{pile.map(&:size).join(' ')}\n"
        end
    end

    def prompt
        puts "enter pile position to take from"
        from = gets.chomp.to_i 
        puts "enter pile position to move to "
        to = gets.chomp.to_i 
        [from , to]
    end

    def move(from, to)
        raise "tower #{from} is empty" if piles[from].empty?
        raise "can not move to a smaller tower" if !piles[to].empty? && piles[to].first.size < piles[from].first.size 
        disc = piles[from].shift 
        piles[to].unshift(disc) 
    end

    def won?
        return false unless piles[0].empty?
        (piles[1].empty?) ? correct_order?(2) : correct_order?(1)
    end

    def correct_order?(pos)
        piles[pos].map(&:size) == (1..size).to_a 
    end
end

#  h = Hanoi.new
#  h.play
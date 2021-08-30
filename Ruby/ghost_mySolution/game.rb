require 'byebug'
require 'set'
require_relative 'Player.rb'



class Game 
    def initialize (*players)
        words = File.readlines("dictionary.txt").map(&:chomp)   # every line is an element in Array words
        @players = players
        @dictionary = Set.new(words)
        @losses = Hash.new(0)
    end

    def next_player!
        @players.rotate!(1)
    end

    def current_player
        @players.first
    end

    def previous_player      # when they depend on array player and need to change rapidly
        @players.last        # as I delete losers..make them better in METHODS NOT VARAIBLES
    end

    def run 
        while @players.length > 1
            play_round
            display_standings     # show scoreboard
            reached_5_losses?
        end
        puts "Yaaah #{@players[0].name}! you are the winner :)"
    end

    def record(player)
        loss = @losses[player]
        word = 'GHOST'
        word[0...loss]
    end
    
    def display_standings
        puts "----------------\n"
        @losses.keys.each do |player|
            puts "#{player.name}      #{record(player)}"
        end
        puts "----------------\n"
    end

    def reached_5_losses?
        @losses.each do |player, loss|
            delete_player(player) if loss == 5
        end
    end

    def delete_player(ply)
        puts "player #{ply.name}, you got GHOST and lost the game :("
        idx = @players.index(ply)
        @players.delete_at(idx) 
        @losses.delete(ply)
    end

    def play_round
        @fragment = ""
        while !lose?
            take_turn(current_player)
        end
        puts "#{previous_player.name} loses the round, the word '#{@fragment}' is in dictionary!"
        @losses[previous_player] += 1
    end

    def lose?
        check_in_dictionary
    end

    def take_turn(player) 
        # debugger
        letter = player.guess
        while !valid_play?(letter)
            puts "Invalid letter, enter another one.."
            letter = player.guess
        end
        @fragment += letter
        self.next_player!
    end

    # Checks that string is a letter of the alphabet 
    # and that there are words we can spell after adding it to the fragment
    def valid_play?(letter)
        return false unless ('a'..'z').include?(letter.downcase)
        @dictionary.each do |word|     #dictionary is set
            return true if word.start_with?(@fragment + letter)
        end
        false  
    end

    def check_in_dictionary
        @dictionary.each do |word|     
            return true if word == @fragment
        end
        false
    end
end

p1 = Player.new("aya")
p2 = Player.new("josef")
game = Game.new(p1, p2)
game.run

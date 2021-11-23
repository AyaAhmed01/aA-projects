require 'set'
class WordChainer
    attr_reader :dictionary
    attr_accessor :current_words, :visited_words, :new_current_words
    def initialize (dic_file)
        words = File.readlines(dic_file).map(&:chomp)
        @dictionary = Set.new(words)
    end

    def adjacent_words(word)
        # references inside `adjacent_words` to `adjacent_words` will refer to the variable,
        # not the method. This is common, because side-effect free methods
        # are often named after what they return.
        adjacent_words = []
        # NB: I gained a big speedup by checking to see if small
        # modifications to the word were in the dictionary, vs checking
        # every word in the dictionary to see if it was "one away" from
        # the word. WHY? include? in set takes O(logn) while select takes O(n)
        word.each_char.with_index do |old_letter, i|
            ('a'..'z').each do |new_letter|
                next if old_letter == new_letter
                new_word = word.dup 
                new_word[i] = new_letter
                adjacent_words << new_word if dictionary.include?(new_word)
            end
        end
        adjacent_words
        # O(n) .. very SLOW
        # dictionary.select do |dic_word| 
        #     cond = dic_word.length == word.length
        #     cnt = 0
        #     dic_word.each_char.with_index {|ch, i| cnt +=1 if word[i] != ch} 
        #     cond && cnt == 1
        # end
    end

    def run(source, target)
        @current_words = [source]
        @visited_words = {source => nil}   # use set/ Hash with what you use include? with
        
        until @current_words.empty? || @visited_words.keys.include?(target) 
            explore_adjacentWords
        end
        
        if !@visited_words.keys.include?(target)
            raise "The #{target} is Not reachable from the #{source}"
        else
            print build_path(target)
        end
    end


    def explore_adjacentWords
        new_current_words = []
        @current_words.each do |curr_word|
            adjacent_words(curr_word).each do |adj_word|
                next if @visited_words.has_key?(adj_word)
                new_current_words << adj_word
                @visited_words[adj_word] = curr_word
            end
        end
        @current_words = new_current_words

    end

    def build_path(target)
        path = []
        curr_word = target
        until curr_word == nil 
            path << curr_word
            curr_word = @visited_words[curr_word]
        end
        path.reverse
    end
    
end

w = WordChainer.new("dictionary.txt")
w.run("mat", "red")

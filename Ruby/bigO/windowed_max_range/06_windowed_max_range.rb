require_relative '05_MinMaxStackQueue.rb'
require 'byebug'
# naive solution
# time: O(n^2)
def windowed_max_range(arr, window_size)
    i, j = 0, window_size - 1
    mx_diff = nil
    while(j < arr.length)      # O(n)
        mx = arr[i..j].max 
        mn = arr[i..j].min     # O(n)
        if mx_diff.nil?
            mx_diff = mx - mn 
        else
            mx_diff = [mx_diff, mx - mn].max 
        end
        i+= 1
        j+= 1
    end
    mx_diff
end

# optimized solution: using MinMaxStackQueue
# O(2n) => O(n)

def fast_windowed_max_range(arr, window_size)
    mx_diff = nil
    queue = MinMaxStackQueue.new 
    until arr.empty?
        # debugger
        queue.enqueue(arr.pop) until queue.size == window_size
        curr_diff = queue.max - queue.min 
        mx_diff = curr_diff if mx_diff.nil? || curr_diff > mx_diff
        queue.dequeue
    end
    mx_diff
end

puts fast_windowed_max_range([1, 0, 4, 8], 2) # == 4 
puts fast_windowed_max_range([1, 0, 2, 5, 4, 8], 3) #== 5 
puts fast_windowed_max_range([1, 0, 2, 5, 4, 8], 4) #== 6 
puts fast_windowed_max_range([1, 3, 2, 5, 4, 8], 5) #== 6 
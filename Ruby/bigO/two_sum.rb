# time: O(n^2)
# space: O(1)
def bad_two_sum?(arr, target_sum)
    arr.each_with_index do |a, i|
        arr.each_with_index do |b, j|
            next if i == j
            return true if a + b == target_sum
        end
    end
    false 
end

# time: O(nlogn)
# space: O(1)
def okay_two_sum?(arr, target_sum)
    arr.each do |a|
        b = target_sum - a 
        bsearch_res = arr.sort.bsearch{|val| b <=> val}
        return true unless bsearch_res.nil? || bsearch_res == a  # arr elements are distinct
    end
    false 
end

# time: O(n)
# space: O(n)
def fast_two_sum?(arr, target_sum)
    frq = Hash.new(0)
    arr.each {|ele| frq[ele] = 1}
    arr.each do |ele1|
        ele2 = target_sum - ele1
        return true if frq[ele2] == 1 && ele1 != ele2
    end
    false 
end

arr = [0, 1, 5, 7]
p fast_two_sum?(arr, 6) # => should be true
p fast_two_sum?(arr, 10) # => should be false
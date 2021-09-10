#O(n) linear time
#O(1) constant space
def largest_contiguous_subsum (arr)
    mx = arr[0]
    cur = arr[0]
    j = 1
    while j < arr.length do
        cur = 0 if cur < 0
        cur += arr[j]
        mx = (mx > cur ? mx : cur) 
        j+=1
    end
    mx 
end

# Anagrams

# time complexity: O(n!)
# space complexity: O(n!)
def first_anagram?(a, b)
    all_anagrams = a.split('').permutation.to_a
    all_anagrams.join('').include?(b)
end

# time complexity: O(n^2)
# space complexity: O(1)
def second_anagram?(a, b)
    a.each_char do |ch|
        i = b.split('').find_index(ch)
        b = b[0...i] + b[i+1..-1] unless i.nil?
    end
    b.empty?
end

# time complexity: O(nlogn)
# space complexity: O(1)
def third_anagram?(a, b)
    a.split('').sort.join('') == b.split('').sort.join('')
end

# time complexity: O(n + m)
# space complexity: O(1)
# Here, the intuitive answer to the space complexity is
  # O(n) because we're adding a separate key in the hash
  # for each character. But if the keys in the hash are single 
  # characters, then how many different keys can we have? 
  # How many different chars in the alphabet? A constant number 
  # (26 + numbers and symbols for English alphabet).

def fourth_anagram?(a, b)
    frq = Hash.new(0)
    a.each_char{|ch| frq[ch]+=1}
    b.each_char{|ch| frq[ch]+=1}
    frq.values.all?{|val| val == 2}
end 

p fourth_anagram?("gizmo", "sally")    #=> false
p fourth_anagram?("elvis", "lives")    #=> true


require_relative 'super_useful'

begin 
puts "'five' == #{convert_to_int('five')}"
rescue => e 
    puts "#{e.message}"
end

feed_me_a_fruit

begin 
sam = BestFriend.new('aya', 6, 'alaa')
sam.talk_about_friendship
sam.do_friendstuff
sam.give_friendship_bracelet

rescue RuntimeError => e 
    puts "#{e.message}"
rescue ArgumentError => e 
    puts "#{e.message}"
ensure
    puts "end of text."
end



# PHASE 2
def convert_to_int(str)
  raise RuntimeError
  Integer(str)
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]
class CoffeeError < StandardError
end

class NonFruitError < StandardError
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == 'coffee'
    raise CoffeeError
  else
    raise NonFruitError
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  begin
  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit) 
  rescue NonFruitError => e 
    puts "It is not a fruit nor a coffee :("
  rescue CoffeeError => e 
    puts "You give me a coffee, you can try feeding me again :)"
    retry
  end
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
    raise RuntimeError.new("Not best frient, years_known is less than 5") if yrs_known < 5
    raise ArgumentError.new("Name and fav_pastime can not be empty..") if name.length == 0 || fav_pastime.length == 0
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end



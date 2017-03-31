class Player

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess(fragment, _)
    puts "It is #{@name}'s turn, and the current fragment is #{fragment}."
    puts "Please enter a letter to add to the fragment."
    alphabet = ("a".."z").to_a
    input = gets.chomp
    unless alphabet.include?(input)
      puts "Input is not a single letter. Try again."
      guess(fragment)
    end
    input
  end

  def alert_invalid_guess
    puts "#{@name} has created a fragment that matches no words."
  end
end

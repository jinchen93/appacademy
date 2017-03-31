require_relative 'Player'
require 'byebug'

class AiPlayer < Player
  def initialize(name, dictionary)
    @name = name
    @dictionary = dictionary
  end

  def guess(fragment, num_players)
    matching_words = find_valid_words(fragment)
    choose_letter(matching_words, fragment, num_players)
  end

  def alert_invalid_guess
    puts "#{@name} has created a fragment that matches no words."
  end

  private
  def find_valid_words(fragment)
    words = @dictionary.grep(/^#{fragment}/)
    to_remove = []
    words.each do |word|
      if word.length == fragment.length + 1
        to_remove << word
        to_remove += words.grep(/^#{word}/)
      end
    end
    if words - to_remove.uniq == []
      words
    else
      words -= to_remove.uniq
    end
  end

  def choose_letter(words, fragment, num_players)
    words.sort_by!(&:length)

    n = 1
    longest_word_length = words.last.length
    until n * num_players > longest_word_length
      words = words.reject do |word|
        word.length == fragment.length + 1 + (n * num_players)
      end
      n += 1
    end
    next_letter_options = Hash.new(0)
    words.each do |word|
      next_letter_options[word[fragment.length]] += 1
    end
    next_letter_options.min_by { |key, val| val }[0]
  end
end

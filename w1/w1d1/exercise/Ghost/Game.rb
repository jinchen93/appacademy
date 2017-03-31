require 'pry'
require_relative 'Player'
require_relative 'AiPlayer'

class Game
  def initialize(players, dictionary)
    @players = players
    @dictionary = dictionary
    @fragment = ""
    @current_player = players.first
    @previous_player = nil
    @losses = {}
    players.each do |player|
      @losses[player.name] = 0
    end
  end

  def run
    until @players.length == 1
      play_round
      @fragment = ""
    end
    puts "#{@players.first.name} is the last man standing, you win!"
  end

  def play_round
    until end_round?
      take_turn(@current_player)
    end
    @losses[previous_player.name] += 1
    puts "#{@previous_player.name} has completed a valid word, #{@fragment}."
    puts "#{@previous_player.name} loses this round!"
    puts "#{record(@previous_player)}"
    eliminate_player(@previous_player) if @losses[previous_player.name] == 5
  end

  def eliminate_player(player)
    @players.delete(player)
  end

  def end_round?
    @dictionary.include?(@fragment)
  end

  def current_player
    @current_player
  end

  def previous_player
    @previous_player
  end

  def next_player!
    @previous_player = @current_player
    @players = @players.rotate
    @current_player = @players.first
  end

  def take_turn(player)
    letter = player.guess(@fragment, @players.length)
    if valid_play?(letter)
      @fragment += letter
      next_player!
    else
      player.alert_invalid_guess
    end
  end

  def valid_play?(string)
    new_fragment = @fragment + string
    @dictionary.grep(/^#{new_fragment}/) != []
  end

  def losses
    @losses
  end

  def record(player)
    "GHOST"[0...@losses[player.name]]
  end
end

dictionary = File.readlines("dictionary.txt").map { |word| word.chomp }
game = Game.new([AiPlayer.new("Comp", dictionary), Player.new("Chris"), Player.new("Jin")], dictionary)

binding.pry

require_relative 'card'

VALUES = [ 2, 3, 4, 5, 6, 7, 8, 9, 10, :j, :q, :k, :a ]
SUITS = [:diamond, :club, :heart, :spade]

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    setup_deck
  end

  def shuffle
    @cards.shuffle!
  end

  def deal_cards(num_cards)
    @cards.shift(num_cards)
  end

  private
  def setup_deck
    SUITS.each do |suit|
      VALUES.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end
end

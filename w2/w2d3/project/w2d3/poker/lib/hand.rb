class Hand
  attr_reader :player, :cards
  include Comparable

  def initialize(player)
    @player = player
    @cards = []
  end

  def add_cards(cards)
    @cards.concat(cards)
  end

  def is_royal_flush?
    hand_values = cards.map(&:value)
    hand_suits = cards.map(&:suit).uniq
    hand_values == [10, :j, :q, :k, :a] && hand_suits.length == 1
  end
end

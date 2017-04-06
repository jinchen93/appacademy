
class Card
  attr_reader :value, :suit
  include Comparable

  VALUES = [ 2, 3, 4, 5, 6, 7, 8, 9, 10, :j, :q, :k, :a ]
  SUITS = [:diamond, :club, :heart, :spade]

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def ==(other_card)
    @value == other_card.value && @suit == other_card.suit
  end

  def <=>(other_card)
    comp = VALUES.find_index(@value) <=> VALUES.find_index(other_card.value)
    if comp == 0
      comp = SUITS.find_index(@suit) <=> SUITS.find_index(other_card.suit)
    end
    comp
  end

end

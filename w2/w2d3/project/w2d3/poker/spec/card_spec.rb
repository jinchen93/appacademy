require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:q, :heart) }
  SUITS = [:diamond, :club, :heart, :spade]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :j, :q, :k, :a]

  context "#initialize" do
    it "has a valid suit" do
      pass = SUITS.include?(card.suit)
      expect(pass).to be_truthy
    end

    it "has a valid value" do
      pass = VALUES.include?(card.value)
      expect(pass).to be_truthy
    end
  end

  context "#==" do
    it "returns true if card value and suit are the same" do
      other_card = Card.new(:q, :heart)
      expect(card == other_card).to be_truthy
    end
    it "returns false if card suits are not the same" do
      other_card = Card.new(:q, :spade)
      expect(card == other_card).to be_falsey
    end
    it "returns false if card values are not the same" do
      other_card = Card.new(:k, :heart)
      expect(card == other_card).to be_falsey
    end
  end

  context "#<=>" do
    it "returns -1 if card has same value but lower suit than other card" do
      other_card = Card.new(:q, :spade)
      expect(card <=> other_card).to eq(-1)
    end

    it "returns 1 if card has same value but higher suit than other card" do
      other_card = Card.new(:q, :club)
      expect(card <=> other_card).to eq(1)
    end

    it "returns 0 if cards have same value and same suit" do
      other_card = Card.new(:q, :heart)
      expect(card <=> other_card).to eq(0)
    end

    it "returns -1 if card has lower value but same suit as other card" do
      other_card = Card.new(:k, :heart)
      expect(card <=> other_card).to eq(-1)
    end

    it "returns 1 if card has higher value but same suit as other card" do
      other_card = Card.new(:j, :heart)
      expect(card <=> other_card).to eq(1)
    end
  end
end

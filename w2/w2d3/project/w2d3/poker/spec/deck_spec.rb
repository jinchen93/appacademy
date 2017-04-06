require 'rspec'
require 'deck'
require 'byebug'

describe Deck do
  subject(:deck) { Deck.new }

  context "#initialize" do
    it "has a quantity of 52" do
      expect(deck.cards.length).to eq(52)
    end

    it "contains only instances of Cards" do
      pass = deck.cards.all? { |card| card.is_a?(Card) }
      expect(pass).to be_truthy
    end

    it "contains no duplicates" do
      deck.cards.uniq
      expect(deck.cards.length).to eq(52)
    end

    it "contains 13 of each suit" do
      suit_counts = Hash.new(0)

      deck.cards.each do |card|
        suit_counts[card.suit] += 1
      end

      expect(suit_counts[:heart]).to eq(13)
      expect(suit_counts[:diamond]).to eq(13)
      expect(suit_counts[:club]).to eq(13)
      expect(suit_counts[:spade]).to eq(13)
    end

    it "contains 4 of each value" do
      value_counts = Hash.new(0)

      deck.cards.each do |card|
        value_counts[card.value] += 1
      end

      values_pass = value_counts.values.all? { |value| value == 4 }
      expect(values_pass).to be_truthy
    end
  end

  context "#shuffle" do

    it "shuffles the deck randomly" do
      old_cards = deck.cards.dup
      deck.shuffle
      expect(deck.cards).to_not eq(old_cards)
    end
  end

  context "#deal_cards" do

    it "returns an array of cards" do
      dealt_cards = deck.deal_cards(5)
      pass = dealt_cards.all? { |card| card.is_a?(Card) }

      expect(pass).to be_truthy
    end

    it "removes the correct number of cards from the deck" do
      deck.deal_cards(5)
      expect(deck.cards.length).to eq(47)
    end
  end

end

require 'rspec'
require 'hand'

describe Hand do
  let(:player) { double("player") }
  subject(:hand) { Hand.new(player) }

  context "#initialize" do
    it "initializes to an empty hand" do
      expect(hand.cards).to be_empty
    end

    it "initializes with a player" do
      expect(hand.player).to be(player)
    end
  end


  context "#add_cards" do
    let(:card) {double("card", :suit => :heart, :value => :q)}
    it "adds the cards to Hand's cards" do
      old_card_length = hand.cards.length
      hand.add_cards([card])
      expect(hand.cards.length).to eq(old_card_length + 1)
    end
  end

  context "#is_royal_flush?" do
    it "detects a royal flush" do
      hand.add_cards([
        double("card", suit: :heart, value: 10),
        double("card", suit: :heart, value: :j),
        double("card", suit: :heart, value: :q),
        double("card", suit: :heart, value: :k),
        double("card", suit: :heart, value: :a)
      ])
      expect(hand.is_royal_flush?).to be_truthy
    end

    it "does not give false positives for straights" do
      hand.add_cards([
        double("card", suit: :heart, value: 10),
        double("card", suit: :spade, value: :j),
        double("card", suit: :heart, value: :q),
        double("card", suit: :heart, value: :k),
        double("card", suit: :heart, value: :a)
      ])
      expect(hand.is_royal_flush?).to be_falsey
    end

    it "does not give false positives for flushes" do
      hand.add_cards([
        double("card", suit: :heart, value: 10),
        double("card", suit: :heart, value: 10),
        double("card", suit: :heart, value: :q),
        double("card", suit: :heart, value: :k),
        double("card", suit: :heart, value: :a)
      ])
      expect(hand.is_royal_flush?).to be_falsey
    end
  end

  context "#is_pair?" do
    it "detects the pair if there is only one pair" do
      hand.add_cards([
        double("card", suit: :heart, value: 10),
        double("card", suit: :spade, value: :j),
        double("card", suit: :heart, value: :q),
        double("card", suit: :spade, value: 10),
        double("card", suit: :heart, value: :a)
      ])
      expect(hand.is_pair?).to be_truthy
    end

    it "detects pairs if there is two pairs" do
      hand.add_cards([
        double("card", suit: :heart, value: 10),
        double("card", suit: :spade, value: 9),
        double("card", suit: :heart, value: 10),
        double("card", suit: :diamond, value: 9),
        double("card", suit: :heart, value: :a)
      ])
      expect(hand.is_pair?).to be_truthy
    end

    it "detects if there is no pair" do
      hand.add_cards([
        double("card", suit: :heart, value: 10),
        double("card", suit: :spade, value: :j),
        double("card", suit: :heart, value: 9),
        double("card", suit: :diamond, value: 8),
        double("card", suit: :heart, value: :a)
      ])
      expect(hand.is_pair?).to be_falsey
    end
  end

  context "#is_three_of_a_kind?" do
    it "detects if a three of a kind is present" do
      hand.add_cards([
        double("card", suit: :heart, value: 10),
        double("card", suit: :spade, value: 10),
        double("card", suit: :heart, value: 9),
        double("card", suit: :diamond, value: 10),
        double("card", suit: :heart, value: :a)
      ])

      expect(hand.is_three_of_a_kind?).to be_truthy
    end
  end
end

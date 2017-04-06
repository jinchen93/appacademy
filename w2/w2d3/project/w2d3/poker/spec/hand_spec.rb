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
    before(:each) do
      hand.add_cards([
        Card.new(10, :spade),
        Card.new(:j, :spade),
        Card.new(:q, :spade),
        Card.new(:k, :spade),
        Card.new(:a, :spade)
        ])
    end

    it "detects a royal flush" do
      expect(hand.is_royal_flush?).to be_truthy
    end
  end

end

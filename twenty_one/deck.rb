class Deck
  def initialize
    @suits = [:Hearts, :Diamonds, :Spades, :Clubs]
    @values = (1..9).to_a + ['King', 'Queen', 'Jack', 'Ace']
    @deck = create_deck
  end

  def deal
    hand, suits = [], []
    2.times { suits << @deck.keys.sample }
    suits.each { |suit| hand << @deck[suit].shuffle!.shift }
    hand
  end

  def add_card
    card = @deck.keys.sample
    @deck[card].shuffle!.shift
  end

  private

  def create_deck
    deck = {}
    @suits.each { |suit| deck[suit] = @values }
    deck
  end
end
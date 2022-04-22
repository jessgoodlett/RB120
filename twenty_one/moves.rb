module Moves
  attr_accessor :hand

  def initialize
    @hand = nil
  end

  def deal_hand(cards)
    @hand = cards
  end

  def hit(card)
    hand << card
  end

  def busted?
    total > 21
  end

  def total
    total = 0
    hand.each do |card|
      if card == "Ace"
        total += 11
      elsif card.to_i == 0
        total += 10
      else
        total += card
      end
    end
  
    hand.select { |card| card == "Ace" }.count.times { total -= 10 if total > 21 }
    total
  end
end
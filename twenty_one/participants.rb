$LOAD_PATH.unshift(__dir__)
require "moves"

class Player
  include Moves
end

class Dealer
  include Moves

  def hit(card)
    puts "DEALER HITS!"
    hand << card
    sleep 0.5
  end
end
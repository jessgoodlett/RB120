$LOAD_PATH.unshift(__dir__)
require "participants"
require "deck"
require 'io/console'

class Game
  attr_accessor :deck, :player, :dealer

  VALID_INPUT = ['hit', 'h', 'stay', 's']

  def initialize
    @deck = Deck.new # this will create all the card possibilities
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    display_welcome_message
    clear
    loop do
      deal_cards
      player_turn
      player.busted? ? show_result : dealer_turn
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  private

  def reset
    self.deck = Deck.new
    clear
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
    puts "----------------------------------"
    puts "Press any key to start the game."
    STDIN.getch
  end

  def show_title
    clear
    puts "Twenty-One"
    puts "----------------------------------"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty-One!"
  end

  def deal_cards
    player.deal_hand(deck.deal)
    dealer.deal_hand(deck.deal)
  end

  def show_players_hand
    puts "Dealer has #{dealer.hand[0]} and an unknown card."
    puts ""
    puts "Player has #{player.hand.join(', ')}"
    puts "Player's total is: #{player.total}"
  end

  def valid_choice
    choice = nil
    loop do
      puts "Would you like to 'hit' or 'stay'?"
      choice = gets.chomp.downcase
      break if VALID_INPUT.include?(choice)
      puts "Invalid input. Please try again."
    end
    choice
  end

  def player_turn
    loop do
      show_title
      show_players_hand
      choice = valid_choice
      choice[0] == 'h' ? player.hit(deck.add_card) : break
      # clear
      break if player.busted?
    end
  end

  def totals
    puts "Player total: #{player.total}"
    puts "Dealer total: #{dealer.total}"
  end

  def dealer_turn
    loop do
      show_title
      break if dealer.total >= 17 || dealer.busted?
      sleep 0.5
      dealer.hit(deck.add_card)
      totals
    end
    show_result
  end

  def show_busted
    puts "Player busted! Dealer wins!" if player.busted?
    puts "Dealer busted! Player wins!" if dealer.busted?
  end

  def show_result
    show_title
    if player.busted? || dealer.busted?
      show_busted
    elsif player.total > dealer.total
      puts "Player wins!"
    elsif player.total < dealer.total
      puts "Dealer wins!"
    else
      puts "It's a tie!"
    end
    totals
  end

  def play_again?
    puts "Would you like to play again? (y or n)"
    answer = gets.chomp.downcase
    answer.start_with?('y')
  end

  def clear
    system("cls") || system("clear")
  end
end

game = Game.new
game.start

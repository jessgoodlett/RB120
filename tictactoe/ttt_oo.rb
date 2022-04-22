$LOAD_PATH.unshift(__dir__)
require "board"
require "square"
require "player"

class TTTGame
  attr_accessor :board, :human, :computer

  def initialize
    @human = Human.new('X')
    @computer = Computer.new('O')
    @computer = Computer.new('O')
    @board = Board.new
  end

  def play
    clear
    display_welcome_message
    loop do
      play_one_round
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  private

  def play_one_round
    loop do
      display_board
      human_moves
      break if board.winner? || board.full?
      computer_moves
      break if board.winner? || board.full?
    end
    display_result
  end

  def display_welcome_message
    puts "Welcome! Let's play!"
  end

  def display_board
    puts "Tic Tac Toe"
    board.draw
  end

  def human_moves
    placement = nil
    puts "Which square would you like to place your #{human.marker}?"
    loop do
      puts board.empty_positions.join(', ')
      placement = gets.chomp.to_i
      break if board.empty_positions.include?(placement)
      puts "That square is not available... Please try again."
    end
    board.mark(placement, human.marker)
  end

  def computer_moves
    sleep 0.5
    clear
    placement = board.empty_positions.sample
    board.mark(placement, computer.marker)
  end

  def display_result
    clear
    display_board
    winner = board.winning_marker == 'X' ? "Player One" : "Computer"
    puts "The winner is #{winner}!"
  end

  def clear
    system("cls") || system("clear")
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n"
    end
    answer == 'y'
  end

  def reset
    board.reset
    clear
    puts "Let's play again!"
  end
end

game = TTTGame.new
game.play

# possibile additions // bonus features
# set player name and computer name
# level: easy, medium, hard (computer offense and defense)
# choose your marker (this will also determine who starts)
# keep a score
# play to certain score
# better board.draw method
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                   [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                   [[1, 5, 9], [3, 5, 7]]

  def initialize
    reset
  end

  def draw
    puts ""
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+------ "
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+------ "
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts ""
  end

  def empty_positions
    @squares.select { |_, v| v == " " }.keys
  end

  def mark(placement, marker)
    @squares[placement] = marker
  end

  def full?
    empty_positions.empty?
  end

  def winner?
    !!winning_marker
  end

  def reset
      @squares = (1..9).to_a.to_h { |position| [position, Square.new.marker] }
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares[1] if all_identical_markers?(squares)
    end
    nil
  end

  private

  def all_identical_markers?(squares)
    squares.all? { |square| square == 'X'} || squares.all? { |square| square == 'O'}
  end
end

# i don't like the draw method
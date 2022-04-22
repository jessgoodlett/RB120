class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class Human < Player; end
class Computer < Player; end
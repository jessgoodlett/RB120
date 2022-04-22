class Square
  attr_accessor :marker

  def initialize(marker = " ")
    @marker = marker
  end

  def to_s
    @marker
  end
end
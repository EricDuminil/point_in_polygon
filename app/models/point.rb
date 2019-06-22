class Point
  attr_reader :x, :y
  alias longitude x
  alias latitude y

  def initialize(x, y)
    @x = Float(x)
    @y = Float(y)
  end

  def coordinates
    [x, y]
  end

  def ==(other)
    x == other.x && y == other.y
  end
end

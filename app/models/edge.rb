class Edge
  attr_reader :v1, :v2

  def initialize(v1, v2)
    @v1 = v1
    @v2 = v2
  end

  # http://geomalgorithms.com/a03-_inclusion.html
  def winding_number(point)
    return 1 if upward_crossing?(point) && left_of_line?(point)
    return -1 if downward_crossing?(point) && right_of_line?(point)

    0
  end

  private

  def upward_crossing?(point)
    (v1.y <= point.y) && (v2.y > point.y)
  end

  def downward_crossing?(point)
    (v1.y > point.y) && (v2.y <= point.y)
  end

  def left_of_line?(point)
    compare_position(point) > 0
  end

  def right_of_line?(point)
    compare_position(point) < 0
  end

  def on_line?(point)
    compare_position(point) == 0
  end

  # From http://geomalgorithms.com/a03-_inclusion.html
  #
  # tests if a point is Left|On|Right of an infinite line.
  # //    Input:  three points P0, P1, and P2
  # //    Return: >0 for P2 left of the line through P0 and P1
  # //            =0 for P2  on the line
  # //            <0 for P2  right of the line
  # //    See: Algorithm 1 "Area of Triangles and Polygons"
  def compare_position(point)
    (v2.x - v1.x) * (point.y - v1.y) - (point.x - v1.x) * (v2.y - v1.y)
  end
end

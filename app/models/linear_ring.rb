class LinearRing
  attr_reader :edges, :vertices

  def initialize(coordinates)
    @vertices = coordinates.map { |x, y| Point.new(x, y) }
    close_ring_if_needed!
    @edges = vertices.each_cons(2).map { |v1, v2| Edge.new(v1, v2) }
  end

  def winding_number(point)
    edges.sum { |edge| edge.winding_number(point) }
  end

  def coordinates
    vertices.map(&:coordinates)
  end

  private

  def close_ring_if_needed!
    vertices << vertices.first unless closed?
  end

  def closed?
    vertices.first == vertices.last
  end
end

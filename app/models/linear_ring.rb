class LinearRing
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
    close_ring_if_needed!
  end

  private

  def close_ring_if_needed!
    coordinates = coordinates + [coordinates.first] unless closed?
  end

  def closed?
    coordinates.first == coordinates.last
  end
end

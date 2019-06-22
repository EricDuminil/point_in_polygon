class Polygon
  attr_reader :longitude_range, :latitude_range
  attr_reader :rings

  def initialize(geometry)
    @rings = geometry.coordinates.map{ |ring_coordinates| LinearRing.new(ring_coordinates) }
    calculate_bounding_box
  end

  def contains?(point)
    return false unless bounding_box_contains? point
    winding_number(point).nonzero?
  end

  def bounding_box_contains?(point)
    longitude_range.include?(point.longitude) &&
      latitude_range.include?(point.latitude)
  end

  # Algorithm described at http://geomalgorithms.com/a03-_inclusion.html
  def winding_number(point)

  end

  private

  def calculate_bounding_box
    lons, lats = rings.flat_map(&:coordinates).transpose
    @longitude_range = Range.new(*lons.minmax)
    @latitude_range = Range.new(*lats.minmax)
  end
end

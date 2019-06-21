class Polygon
  attr_reader :longitude_range, :latitude_range
  attr_reader :geometry

  def initialize(geometry)
    @geometry = geometry
    calculate_bounding_box
  end

  def contains?(point)
    #FIXME: Very basic check based on the bounding box. It is only correct for axis-aligned rectangles.
    longitude_range.include?(point.longitude) &&
      latitude_range.include?(point.latitude)
  end

  private

  def calculate_bounding_box
    lons, lats =  geometry.coordinates.flatten(1).transpose
    @longitude_range = Range.new(*lons.minmax)
    @latitude_range = Range.new(*lats.minmax)
  end
end

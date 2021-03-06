class Area
  SOURCE = Rails.root.join('db', 'Given_areas.json')
  attr_reader :geometry

  def self.all
    @@areas ||= import File.read(SOURCE)
  end

  # Checks if a point is strictly inside at least one of the areas.
  # Depending on polygon orientation and floating point errors, points on vertices or edges cannot be reliably considered to be inside the polygon.
  def self.contains?(longitude, latitude) # WARNING! Lon/Lat convention, as in GeoJSON
    point = Point.new(longitude, latitude)
    all.any? do |area|
      area.geometry.contains? point
    end
  end

  def self.all_as_geo_json
    all # to make sure SOURCE has been imported
    @@geo_json
  end

  def initialize(polygon_feature)
    @geometry = Polygon.new(polygon_feature.geometry)
  end

  private

  def self.import(geo_json)
    @@geo_json = geo_json
    JSON.parse(geo_json, object_class: OpenStruct).features.map { |feature| Area.new(feature) }
  end
end

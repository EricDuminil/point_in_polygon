class Area
  SOURCE = Rails.root.join('db/Given_areas.json')
  attr_reader :geometry

  def self.all
    @@areas ||= import File.read(SOURCE)
  end

  def self.contains?(longitude, latitude) #WARNING! Lon/Lat convention, as in GeoJSON
    point = factory.point(Float(longitude), Float(latitude))
    all.any? do |area|
      area.geometry.contains? point
    end
  end

  def self.all_as_geo_json
    all # to make sure SOURCE has been imported
    @@geo_json
  end

  def initialize(polygon_feature)
    @geometry = polygon_feature.geometry
  end

  private

  def self.factory
    @@factory ||= RGeo::Cartesian.factory
  end

  def self.import(geo_json)
    @@geo_json = geo_json
    raise "Geos should be supported! Install libgeos-3.5.0 and libgeos-dev packages before reinstalling rgeo gem" unless RGeo::Geos.supported?
    RGeo::GeoJSON.decode(geo_json).map{|feature| Area.new(feature) }
  end
end

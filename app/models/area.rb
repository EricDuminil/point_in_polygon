class Area
  SOURCE = Rails.root.join('db/Given_areas.json')
  attr_reader :geometry

  def self.all
    @@areas ||= import File.read(SOURCE)
  end

  def self.contains?(geo_json_point)
    point = RGeo::GeoJSON.decode(geo_json_point)
    all.any? do |area|
      area.contains? point
    end
  end

  def contains?(point)
    geometry.contains? point
  end

  def self.to_json
    all && @@json
  end

  def initialize(polygon_feature)
    @geometry = polygon_feature.geometry
  end

  private

  def self.import(geo_json)
    @@json = geo_json
    raise "Geos should be supported! Install libgeos-3.5.0 and libgeos-dev packages before reinstalling rgeo gem" unless RGeo::Geos.supported?
    RGeo::GeoJSON.decode(geo_json).map{|feature| Area.new(feature) }
  end
end

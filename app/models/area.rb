class Area
  SOURCE = Rails.root.join('db/Given_areas.json')

  def self.all
    @@all ||= import File.read(SOURCE)
  end

  private

  def self.import(geo_json)
    RGeo::GeoJSON.decode(geo_json)
  end
end

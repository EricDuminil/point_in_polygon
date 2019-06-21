class Point
  attr_reader :longitude, :latitude
  def initialize(longitude, latitude)
    @longitude = Float(longitude)
    @latitude = Float(latitude)
  end
end

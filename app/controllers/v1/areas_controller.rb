class V1::AreasController < ApplicationController
  before_action :extract_coordinates, only: [:contain]

  def index
    render json: Area.all_as_geo_json
  end

  def contain
    render json: Area.contains?(@longitude, @latitude)
  end

  private

  # Coordinates can be in different places inside params
  def extract_coordinates
    @longitude = Float(params[:longitude] || params.dig(:coordinates, 0) || params.dig(:geometry, :coordinates, 0))
    @latitude = Float(params[:latitude] || params.dig(:coordinates, 1) || params.dig(:geometry, :coordinates, 1))
  rescue TypeError, ArgumentError => e
    invalid_coordinates!(e)
  end

  def invalid_coordinates!(exception)
    render json: { error:
                  [
                    'Invalid coordinates!',
                    'Please add :latitude and :longitude as parameters, send a GeoJSON of type Point, or a GeoJSON Feature Point.',
                    "Example: #{v1_areas_contain_url(latitude: 50.77, longitude: 9.77)} .",
                    "Error Message: '#{exception.message}'"
                  ].join(' ') }, status: :bad_request
  end
end

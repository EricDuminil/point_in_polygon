class V1::AreasController < ApplicationController
  rescue_from TypeError, :with => :incorrect_coordinates
  rescue_from ArgumentError, :with => :incorrect_coordinates

  def index
    render json: Area.all_as_geo_json
  end

  def contain
    longitude = params[:longitude] || params.dig(:coordinates, 0)
    latitude = params[:latitude] || params.dig(:coordinates, 1)
    render json: Area.contains?(longitude, latitude)
  end

  private

  def incorrect_coordinates(exception)
    render json: {error: "Invalid coordinates! #{exception.message}"}, status: 500
  end
end

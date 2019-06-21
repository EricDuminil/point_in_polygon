class V1::AreasController < ApplicationController
  def index
    render json: Area.to_json
  end

  def contain
    longitude = params[:longitude] || params.dig(:coordinates, 0)
    latitude = params[:latitude] || params.dig(:coordinates, 1)
    render json: Area.contains?(longitude, latitude)
  end
end

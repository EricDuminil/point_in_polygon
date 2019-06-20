class V1::AreasController < ApplicationController
  def index
    render json: Area.to_json
  end

  def contain
    latitude = params[:latitude] || params[:coordinates].last
    longitude = params[:longitude] || params[:coordinates].first
    render json: Area.contains?(longitude.to_f, latitude.to_f)
  end
end

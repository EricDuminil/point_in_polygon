class V1::AreasController < ApplicationController
  def index
    render json: Area.to_json
  end

  def contain
    point = {type: 'Point', coordinates: [params[:longitude], params[:latitude]]}.to_json #TODO: DRY
    render json: Area.contains?(point)
  end
end

class V1::AreasController < ApplicationController
  def index
    render json: Area.to_json
  end
end

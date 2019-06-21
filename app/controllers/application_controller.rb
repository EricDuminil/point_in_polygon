class ApplicationController < ActionController::API
  def unknown_route
    render json: {error: "The desired resource doesn't exist."}, status: :not_found
  end
end

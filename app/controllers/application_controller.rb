class ApplicationController < ActionController::API
  def unknown_route
    known_routes = [
      v1_areas_url,
      v1_areas_contain_url
    ]

    render json: {error: "The desired resource doesn't exist. Please try #{known_routes.to_sentence}. Visit https://github.com/EricDuminil/point_in_polygon for more info."}, status: :not_found
  end
end

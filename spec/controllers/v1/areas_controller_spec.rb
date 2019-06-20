require 'rails_helper'

RSpec.describe V1::AreasController, type: :controller do
  describe "GET index" do
    it "show the list of the given areas in GeoJSON format" do
      get :index
      json_response = response.body
      expect(json_response).to include('Polygon')
      areas = JSON.parse(json_response)
      expect(areas["type"]).to eq('FeatureCollection')
      expect(areas["features"]).to be_an(Array)
      expect(areas["features"].size).to eq 6
      expect(areas.dig('features', 0, 'type')).to eq "Feature"
      expect(areas.dig('features', 0, 'geometry', 'type')).to eq "Polygon"
    end
  end
end

require 'rails_helper'

RSpec.describe V1::AreasController, type: :controller do
  describe "GET index" do
    it "returns the list of the given areas in GeoJSON format" do
      get :index
      json_response = response.body
      expect(json_response).to include('Polygon')
      areas = JSON.parse(json_response)
      expect(areas["type"]).to eq('FeatureCollection')
      expect(areas["features"]).to be_an(Array)
      expect(areas["features"].size).to eq 6
      expect(areas.dig('features', 0, 'type')).to eq "Feature"
      expect(areas.dig('features', 0, 'geometry', 'type')).to eq "Polygon"
      expect(areas.dig('features', 0, 'geometry', 'coordinates', 0, 0, 0)).to be_a Numeric
    end
  end

  describe "GET contain" do
    context "when called with latitude & longitude params" do
      it "returns a boolean" do
        get :contain, params: {latitude: 0, longitude: 0}
        json_response = response.body
        is_inside = JSON.parse(json_response)
        expect(is_inside).to be(false).or be(true)
      end

      it "returns true for Frankfurt" do
        get :contain, params: {latitude:50.1109, longitude:8.6821}
        expect(response.body).to eq "true"
      end

      it "returns false for Frankfurt" do
        get :contain, params: {latitude:51.5074, longitude:-0.1278}
        expect(response.body).to eq "false"
      end
    end

    context "when called without params" do
      it "sends an error message" do
        get :contain
        pending "it should fail"
      end
    end
  end
end

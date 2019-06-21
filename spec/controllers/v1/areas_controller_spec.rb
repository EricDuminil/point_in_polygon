require 'rails_helper'

#TODO: DRY Frankfurt & London!

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
      it "returns with status 200" do
        get :contain, params: {latitude: 0, longitude: 0}
        expect(response).to have_http_status(:success)
      end

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

      it "returns false for London" do
        get :contain, params: {latitude:51.5074, longitude:-0.1278}
        expect(response.body).to eq "false"
      end
    end

    context "when called with coordinates params" do
      it "returns true for Frankfurt" do
        get :contain, params: {coordinates: [8.6821, 50.1109]}
        expect(response.body).to eq "true"
      end

      it "returns false for London" do
        get :contain, params: {coordinates: [-0.1278, 51.5074]}
        expect(response.body).to eq "false"
      end
    end

    context "when called with a GeoJSON Point" do
      it "returns true for Frankfurt" do
        get :contain, params: {type:"Point", coordinates: [8.6821, 50.1109]}, as: :json
        expect(response.body).to eq "true"
      end

      it "returns false for London" do
        get :contain, params: {type:"Point", coordinates: [-0.1278, 51.5074]}, as: :json
        expect(response.body).to eq "false"
      end
    end

    context "when called with a GeoJSON Point Feature" do
      it "returns true for Frankfurt" do
        get :contain, params: {type: "Feature", geometry: {type:"Point", coordinates: [8.6821, 50.1109]}}, as: :json
        expect(response.body).to eq "true"
      end

      it "returns false for London" do
        get :contain, params: {type: "Feature", geometry: {type:"Point", coordinates: [-0.1278, 51.5074]}}, as: :json
        expect(response.body).to eq "false"
      end
    end

    context "when called without params" do
      it "sends an error message" do
        get :contain
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to include "Invalid coordinates!"
      end
    end

    context "when called with incorrect params" do
      it "sends an error message" do
        incorrect_params = [
          {latitude: 48.77},
          {coordinates: ["ABC", "DEF"]},
          {coordinates: [1]},
          {id: 3},
          {type:"Polygon", coordinates:[[[0.0, 1.0],[1.0,0.0],[0.0,0.0]]]}
        ]

        incorrect_params.each do |params|
          get :contain, params: params
          expect(response).to have_http_status(:bad_request)
          expect(response.body).to include "Invalid coordinates!"
        end
      end
    end
  end

  describe "GET any_other_action" do
    it "sends an error message" do
      get "hello_world"
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "POST any_action" do
    it "sends an error message" do
      post "hello_world"
      expect(response).to have_http_status(:bad_request)
    end
  end
end

require 'rails_helper'

def geo_json_point(latitude, longitude)
  %Q|{ "type": "Point", "coordinates": [#{longitude}, #{latitude}] }| # WARNING: Lon/Lat Convention!
end

RSpec.describe Area, type: :model do
  context '.all' do
    areas = Area.all

    it 'lists every area' do
      expect(areas).to be_an Enumerable
      expect(areas.size).to eq 6
    end

    it 'contains geometries' do
      areas.each do |area|
        expect(area).to respond_to :geometry
      end
    end
  end

  context '.to_json' do
    it 'exports GeoJSON' do
      geo_json = Area.to_json
      expect(geo_json).to be_a String
      expect(geo_json).to include "Polygon"
      expect(geo_json).to include "46.66451741754235"
      expect(geo_json).to include "13.886718749999998"
    end
  end

  context '.contains?' do
    it 'checks if a given location is inside any of the given areas' do
      expect(Area.contains?(geo_json_point(0, 0))).to eq false
    end

    inside_points = {
      knoxville: [35.979643, -83.920342],
      phoenix: [33.45, -112.066667],
      lilongwe: [-13.983333, 33.783333],
      toulouse: [43.602522, 1.429410],
    }

    inside_points.each do |name, coords|
      it "checks that #{name.to_s.titleize} is inside" do
        expect(Area.contains?(geo_json_point(*coords))).to eq true
      end
    end

    outside_points = {
      salt_lake_city: [40.75, -111.883],
      n_y_c: [40.7128, -74.0060],
      nairobi: [-1.2833, 36.8167],
      monaco: [43.736981, 7.421389],
    }

    outside_points.each do |name, coords|
      it "checks that #{name.to_s.titleize} is outside" do
        expect(Area.contains?(geo_json_point(*coords))).to eq false
      end
    end
  end
end

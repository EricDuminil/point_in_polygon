require 'rails_helper'

RSpec.describe Area, type: :model do
  describe '.all' do
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

  describe '.to_json' do
    it 'exports GeoJSON' do
      geo_json = Area.all_as_geo_json
      expect(geo_json).to be_a String
      expect(geo_json).to include "Polygon"
      expect(geo_json).to include "46.66451741754235"
      expect(geo_json).to include "13.886718749999998"
    end
  end

  describe '.contains?' do
    context 'when called with valid coordinates' do
      it 'returns a boolean' do
        expect(Area.contains?(0, 0)).to be(false).or be(true)
      end

      # Checked with http://geojson.io
      inside_outside_points = {
        inside: {
          knoxville: [35.979643, -83.920342],
          phoenix: [33.45, -112.066667],
          lilongwe: [-13.983333, 33.783333],
          toulouse: [43.602522, 1.429410],
          bratislava: [48.138128, 17.117986],
        },
        outside: {
          salt_lake_city: [40.75, -111.883],
          n_y_c: [40.7128, -74.0060],
          nairobi: [-1.2833, 36.8167],
          monaco: [43.736981, 7.421389],
          wien: [48.2082, 16.3738],
        }
      }

      inside_outside_points.each do |inside_or_outside, points|
        points.each do |name, (lat, lon)|
          it "checks that #{name.to_s.titleize} is #{inside_or_outside}" do
            is_inside = inside_or_outside == :inside
            expect(Area.contains?(lon, lat)).to eq is_inside
          end
        end
      end

      context 'when called with invalid coordinates' do
        it 'raises an Error' do
          [
            ['ABC', 'DEF'],
            ['3°N', '5°W'],
            [nil, 3],
            [nil, nil],
            [3, nil]
          ].each do |lat, lon|
            expect { Area.contains?(lat, lon) }.to raise_error(StandardError)
          end
        end
      end
    end
  end
end

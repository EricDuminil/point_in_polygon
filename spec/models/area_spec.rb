require 'rails_helper'

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
end

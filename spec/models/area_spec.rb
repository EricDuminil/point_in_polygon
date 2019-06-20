require 'rails_helper'

RSpec.describe Area, type: :model do
  context '.all' do
    areas = Area.all

    it 'lists every area' do
      expect(areas).to be_an Enumerable
      expect(areas.size).to eq 6
    end
  end
end

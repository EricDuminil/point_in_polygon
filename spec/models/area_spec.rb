require 'rails_helper'

RSpec.describe Area, type: :model do
  context '.all' do
    it 'lists every area' do
      areas = Area.all
      expect(areas).to be_an Enumerable
    end
  end
end

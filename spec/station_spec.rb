require 'station'

describe Station do
  subject(:station) { described_class.new('Barking', 4) }
  it 'expects the station to know it\'s name' do
    expect(station.name).to eq('Barking')
  end

  it 'expects station to have a zone' do
    expect(station.zone).to eq(4)
  end
end
